enum CurrentRoute {home, login, emailLogin, signup, boad}
CurrentRoute currentRoute = CurrentRoute.home;
void setRoute(int i) {
  if (i == 1) {
    currentRoute = CurrentRoute.home;
  } else if (i == 2) {
    currentRoute = CurrentRoute.login;
  } else if (i == 3) {
    currentRoute = CurrentRoute.emailLogin;
  } else if (i == 4) {
    currentRoute = CurrentRoute.signup;
  } else if (i == 5) {
    currentRoute = CurrentRoute.boad;
  }
}

