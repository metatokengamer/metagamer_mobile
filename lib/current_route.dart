enum CurrentRoute {home, login, emailLogin}
CurrentRoute currentRoute = CurrentRoute.home;
void setRoute(int i) {
  if (i == 1) {
    currentRoute = CurrentRoute.home;
  } else if (i == 2) {
    currentRoute = CurrentRoute.login;
  } else if (i == 3) {
    currentRoute = CurrentRoute.emailLogin;
  }
}

