abstract class NewsStates{}


class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsBusinessLoadingState extends NewsStates{}

class NewsGetBusinessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsSportLoadingState extends NewsStates{}

class NewsGetSportState extends NewsStates{}

class NewsGetSportErrorState extends NewsStates{
  final String error;

  NewsGetSportErrorState(this.error);
}

class NewsScinceLoadingState extends NewsStates{}

class NewsGetScinceState extends NewsStates{}

class NewsGetScinceErrorState extends NewsStates{
  final String error;

  NewsGetScinceErrorState(this.error);
}

class NewsSearchLoadingState extends NewsStates{}

class NewsGetSearchState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{
  final String error;

  NewsGetSearchErrorState(this.error);
}


