enum AppTab{
  Home, Catalog, Favorite, Info
}

AppTab getAppTabFromInt(int index) => AppTab.values[index];

int getIntFromAppTab(AppTab tab) => AppTab.values.indexOf(tab);
