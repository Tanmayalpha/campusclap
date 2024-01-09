import 'package:campusclap/screens/previous_papers_loading_screen.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviousPapers extends StatefulWidget {
  const PreviousPapers({Key? key}) : super(key: key);

  @override
  _PreviousPapersState createState() => _PreviousPapersState();
}

class _PreviousPapersState extends State<PreviousPapers> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: scaffoldKey,
     // appBar: customAppBar(context, translate("Previous_Papers")),
      backgroundColor: Color(0xFFF1F3F8),
      body: contentModel != null &&
              contentModel!.papers!.length == 0
          ? Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(),
                        child: Image.asset("assets/images/emptycategory.png"),
                      ),
                    ),
                    Container(
                      height: 75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Previous_Paper_is_not_available",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(

                                  "There_is_no_Previous_Paper_to_be_shown",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : contentModel != null
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: Icon(
                            Icons.list_alt,
                            size: 50,
                          ),
                          title: Text(
                            contentModel!.papers![index].title!
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            contentModel!.papers![index].detail.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PreviousPapersLoadingScreen(
                                  fileURL: contentModel!.papers![index].filepath.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: contentModel!.papers!.length,
                )
              : SizedBox.shrink(),
    );
  }
}
