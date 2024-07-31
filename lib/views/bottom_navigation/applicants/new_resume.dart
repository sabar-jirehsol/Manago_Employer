import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.2),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                )),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Resume',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0),
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: const Text(
                  "Over 8+ years of experience and web development and 5+ years of experience in mobile applications development "),
            ),
            _buildTitle("Skills"),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                children: [
                  Text('SKILL 1'),
                  const SizedBox(width: 15),
                  Text('SKILL 2'),
                  const SizedBox(width: 15),
                  Text('SKILL 3'),
                  const SizedBox(width: 15),
                  Text('SKILL 4'),
                  const SizedBox(width: 15),
                  Text('SKILL 5'),
                ],
              ),
            ),
            // _buildSkillRow("Wordpress", 0.75),
            // const SizedBox(height: 5.0),
            // _buildSkillRow("Laravel", 0.6),
            // const SizedBox(height: 5.0),
            // _buildSkillRow("React JS", 0.65),
            // const SizedBox(height: 5.0),
            // _buildSkillRow("Flutter", 0.5),
            const SizedBox(height: 30.0),
            _buildTitle("Experience"),
            _buildExperienceRow(
                company: "ABC",
                position: "Wordpress Developer",
                duration: "2010 - 2012"),
            _buildExperienceRow(
                company: "DEF",
                position: "Laravel Developer",
                duration: "2012 - 2015"),
            _buildExperienceRow(
                company: "GHI",
                position: "Web Developer",
                duration: "2015 - 2018"),
            _buildExperienceRow(
                company: "JKL",
                position: "Flutter Developer",
                duration: "2018 - Current"),
            const SizedBox(height: 20.0),
            _buildTitle("Education"),
            const SizedBox(height: 5.0),
            _buildExperienceRow(
                company: "University1",
                position: "B.Sc. Computer Science and Information Technology",
                duration: "2011 - 2015"),
            _buildExperienceRow(
                company: "University2",
                position: "A Level",
                duration: "2008 - 2010"),
            _buildExperienceRow(
                company: "High School", position: "SLC", duration: "2008"),
            const SizedBox(height: 20.0),
            _buildTitle("Contact"),
            const SizedBox(height: 5.0),
            Row(
              children: const <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.mail,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "user@email.com",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: const <Widget>[
                SizedBox(width: 30.0),
                Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "+91-999999999",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            // _buildSocialsRow(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  ListTile _buildExperienceRow(
      {String? company, String? position, String? duration}) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(top: 8.0, left: 20.0),
        child: Icon(
          Icons.circle,
          size: 12.0,
          color: Colors.black54,
        ),
      ),
      title: Text(
        company!,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text("$position ($duration)"),
    );
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16.0),
        Expanded(
            flex: 2,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: level,
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        // const SizedBox(width: 20.0),
        // SizedBox(
        //     width: 80.0,
        //     height: 80.0,
        //     child: CircleAvatar(
        //         radius: 40,
        //         backgroundColor: Colors.grey,
        //         child: CircleAvatar(
        //             radius: 35.0, backgroundImage: NetworkImage(avatars[4])))),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "User Name",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text("Full Stack Developer"),
            const SizedBox(height: 5.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.map,
                  size: 12.0,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "city, state",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
