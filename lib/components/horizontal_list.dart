import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviehub/components/movie_card.dart';
import 'package:themoviehub/services/movies.dart';
import 'list_loading_animation.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({Key key, this.category, this.values}) : super(key: key);

  final String category;
  final List values;

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  bool isLoading = false;
  bool isLoadingAgain = false;
  int page = 1;
  List moviesList = [];
  List<Widget> movieCards = [];
  List<bool> isSelected = [true, false];
  String type;
  List categoryValues;

  @override
  void initState() {
    categoryValues = widget.values;
    toggleLoading();
    type = widget.category == 'trending' ? 'day' : 'theaters';
    getMoviesList(type);

    _scrollController
      ..addListener(() {
        var triggerFetchMore = 0.9 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels >= triggerFetchMore) {
          getMoreMovies();
        }
      });
    super.initState();
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void toggleLoadingAgain() {
    setState(() {
      isLoadingAgain = !isLoadingAgain;
    });
  }

  void getMoreMovies() async {
    page++;
    if (page <= 2) {
      List moreMoviesList =
          await Movies.getMoviesList(widget.category, type, page);
      movieCards.addAll(createCards(moreMoviesList));
      setState(() {});
    }
  }

  void getMoviesList(String type) async {
    page = 1;
    moviesList = await Movies.getMoviesList(widget.category, type, page);
    movieCards = createCards(moviesList);
    isLoading == true ? toggleLoading() : toggleLoadingAgain();
  }

  List<Widget> createCards(var itemList) {
    List<Widget> cardsList = [];
    for (var item in itemList) {
      cardsList.addAll(
        [
          MovieCard(movie: item),
          SizedBox(
            width: 2.0,
          )
        ],
      );
    }
    return cardsList;
  }

  String format(var value) {
    return value.toString().substring(0, 1).toUpperCase() +
        value.toString().substring(1);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print(categoryValues);
    return isLoading == true
        ? ListLoadingAnimation(
            height: 180.0,
          )
        : Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 10.0,
                  bottom: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      format(widget.category),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ToggleButtons(
                      constraints: BoxConstraints(minHeight: 35.0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0.0,
                          ),
                          child: Text(format(categoryValues[0])),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0.0,
                          ),
                          child: Text(format(categoryValues[1])),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (int index) {
                        toggleLoadingAgain();
                        getMoviesList(categoryValues[index]);
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
//                      borderColor: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      focusColor: Colors.green,
                      renderBorder: true,
                      selectedBorderColor: Colors.lightBlue.withOpacity(0.2),
                      borderColor: Colors.grey.withOpacity(0),
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
//                      fillColor: Color(0xFF30376B),
                    ),
                  ],
                ),
              ),
              isLoadingAgain
                  ? ListLoadingAnimation(
                      height: 170.0,
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
//                    width: 100,
                        height: 200,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: movieCards.length,
                          itemBuilder: (context, index) {
                            return movieCards[index];
                          },
                          scrollDirection: Axis.horizontal,
//                        shrinkWrap: true,
                        ),
                      ),
                    ),
            ],
          );
  }
}
