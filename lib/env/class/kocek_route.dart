part of 'package:kocek_app/env/class/kocek_environment.dart';

class KocekRoute {
  const KocekRoute({required this.path, required this.page});

  final String path;
  final Widget page;

  static const KocekRoute playground =
      KocekRoute(path: '/playground_page', page: Playground());

  static const KocekRoute onboarding =
      KocekRoute(path: '/onboarding_page', page: OnBoardingPage());

  static KocekRoute loginOrRegister = KocekRoute(
    path: "/login_or_register",
    page: Builder(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginCubit()),
        ],
        child: const LoginPage(),
      ),
    ),
  );

  static KocekRoute otp = KocekRoute(
    path: "/otp",
    page: Builder(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginCubit()),
        ],
        child: const OtpPage(),
      ),
    ),
  );

  static KocekRoute profileName = KocekRoute(
    path: "/profile_name",
    page: Builder(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginCubit()),
        ],
        child: const ProfileNamePage(),
      ),
    ),
  );

  static KocekRoute auth = KocekRoute(
      path: '/auth_page',
      page: BlocProvider(
          create: (_) => AuthCubit(),
          child: Builder(builder: (to) {
            to.read<AuthCubit>().go();
            return const AuthPage();
          })));
}
