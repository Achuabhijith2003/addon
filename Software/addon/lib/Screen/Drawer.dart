import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
   return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: const Text(
            "JR",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          accountEmail: const Text(
            "Text@text.com",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onDetailsPressed: () {
            print("Profile");
            Navigator.of(context).pushNamed('profile');
          },
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network(
                "https://th.bing.com/th/id/OIP.krsQwriSjmhX_uaLAHsAVgHaHa?w=200&h=200&c=7&r=0&o=5&dpr=1.1&pid=1.7",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/949587/pexels-photo-949587.jpeg?cs=srgb&dl=background-blur-blurred-949587.jpg&fm=jpg"),
                  fit: BoxFit.cover)),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            print("Home");
            Navigator.of(context).pushNamed('home');
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Today'),
          onTap: () {
            print("Toady");
            Navigator.of(context).pushNamed('todaty_calendar');
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month),
          title: const Text('Months'),
          onTap: () {
            print("Months");
            Navigator.of(context).pushNamed('months');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Setting'),
          onTap: () {
            print("Setting");
            Navigator.of(context).pushNamed('setting');
          },
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Share'),
          onTap: () {
            print("Share");
          },
        ),
        ListTile(
          leading: const Icon(Icons.message),
          title: const Text('Report'),
          onTap: () {
            print("report");
            Navigator.of(context).pushNamed('report');
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Exit'),
          onTap: () {
            print("Exit");
            Navigator.of(context).pushNamed('exit');
          },
        ),
      ]),
    );
  }
}
