import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/dreams_utils.dart';


class ResourcesPage extends StatefulWidget{

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: GradientText('Sleep Resources',
          style: TextStyle(fontSize: 30.0,),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
                     colorStyle("gradient3"), colorStyle("gradient2"),
                     colorStyle("gradient1")]
        ),
        backgroundColor: colorStyle("appHeader"),
      ),
      backgroundColor: colorStyle("appBackground"),
      resizeToAvoidBottomInset: true,


      body: Center(
        child: ListView(
          shrinkWrap: true,

         children: <Widget>[

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/SleepF.jpeg",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('Sleep Foundation',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://www.sleepfoundation.org/sleep-hygiene/healthy-sleep-tips')
                    ),
                  ),
                  Text('We work hard to bring you the most accurate and up-to-date information about different sleep health topics. Rest assured every Sleep Foundation guide is carefully vetted and fact-checked prior to publication.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),


          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/IFFA.png",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('International Functional Foods Association',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://iffassociation.org/learn/how-functional-foods-may-improve-sleep-and-immune-health?gclid=Cj0KCQiAys2MBhDOARIsAFf1D1eHFvfuovsyweVETX8I5DOztdqM_QmIN_1DjOtkDNOiKlHIn9RN1bAaAhsLEALw_wcB')
                    ),
                  ),
                  Text('We exist to ensure everyone, everywhere has an equal chance to take control of their own health and wellness.  Functional foods are an important component of healthy, nutritious diets. A diet rich in functional foods promotes a healthy body, as well as a healthy mind.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/Kaiser.png",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('Kaiser Permanente',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://healthengagement.kaiserpermanente.org/wellness-topics/sleep/')
                    ),
                  ),
                  Text('We help people reach their health goals, by listening, supporting and guiding, so they can live their best lives.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/JHM.jpeg",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('John Hopkins Medical',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://www.hopkinsmedicine.org/health/wellness-and-prevention/sleep')
                    ),
                  ),
                  Text('At Johns Hopkins Medicine, your health and safety are our very highest priorities. We are ready to care for you and your family in our hospitals, surgery centers, and through in-person clinic and online video visits. Learn how we are keeping you safe and protected so that you can get the care you need.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/BMI.png",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('Beautiful Mind International',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://beauty-mind.org/sleep-guru/?gclid=Cj0KCQiAys2MBhDOARIsAFf1D1czPDb4ROkA_dhket7YAZrPB9H7AK4OqEclcbTaiU_OgDq9odhQ7x8aAhz7EALw_wcB')
                    ),
                  ),
                  Text('Beautiful Mind International project aims to educate people what is mental health, its issues, and ways to overcome them.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/CDC.png",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('Centers for Disease Control and Prevention',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://www.cdc.gov/sleep/index.html')
                    ),
                  ),
                  Text('The Centers for Disease Control and Prevention is the national public health agency of the United States.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/sleepnum1.jpeg",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('Sleep Number',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://www.sleepnumber.com/categories/beds-on-sale?acid=psnonbrand&ascid=Google%2BNational-_-google-_-NB_Number_Bed-_-Number_Bed_Exact-_-516451220073-_-b-_-kwd-846217698-_-mediacode-_-Beds-_-1&key=number%20beds&s_kwcid=AL!6200!3!516451220073!b!!g!!number%20beds&k_clickid=go_cmp-193921164_adg-14393203044_ad-516451220073_kwd-846217698_dev-c_ext-_prd-&gclid=Cj0KCQiAys2MBhDOARIsAFf1D1d4C7oDgf9l_gikrEEVbK2Y7EpcHjg8AvPAmFGam3Qgjgc-XknDyYYaAtNfEALw_wcB')
                    ),
                  ),
                  Text('Sleep Number is an American manufacturer that makes the Sleep Number and Comfortaire beds, as well as foundations and bedding accessories. The company is based in Minneapolis, Minnesota. In addition to its Minnesota headquarters, Sleep Number has manufacturing and distribution facilities in South Carolina and Utah.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Card(
              color: Colors.transparent,
              elevation: 400.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset("assets/images/sunset.jpeg",
                    height: 400,
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new InkWell(
                        child: new Text('UMN Duluth Health Services',
                          style: TextStyle(
                              color: colorStyle("main"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        onTap: () => launch('https://health-services.d.umn.edu/health-education/sleep-education-initiatives')
                    ),
                  ),
                  Text('Health Education Staff, Interns, and our previous student health advisory committee developed and administered an informal needs assessment to measure student reported barriers to sleep and methods for sleep support that students would use.  We learned a lot and are putting that information into practice with a series of initiatives on campus.',
                    style: TextStyle(
                        color: colorStyle("main"),
                        fontSize: 15.0),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
      ),
    );

  }
}





