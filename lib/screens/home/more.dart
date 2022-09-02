import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/more.png',
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Pixher',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Are you having out of creative story ideas for your social media accounts? We are here to help you to create content for your social media platforms. Pick a template, add image and text of your brand and share. Join us to get early bird access of premium features 100% free.',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  height: 1.5,
                  color: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.color
                      ?.withOpacity(0.7)),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Join us on',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.color
                        ?.withOpacity(0.7)),
              ),
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      'assets/images/instagram.png',
                      height: 44,
                    ),
                    onTap: (){

                    },
                  )
                ],
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
