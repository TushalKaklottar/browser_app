import 'package:browser_app/controller/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  String selectedOption = "Option 1";
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? inAppWebViewController;
  TextEditingController searchController = TextEditingController();
  String Url = "https://www.google.com/";

 @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        await inAppWebViewController?.reload();
      });
    Provider.of<ConnectivityProvider>(context,listen: false).checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Browser",
        style: GoogleFonts.akshar(),
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: Provider.of<ConnectivityProvider>(context,listen: false).selectedOption,
                    child: Row(
                      children: const [
                        Icon(Icons.bookmark_add_outlined,
                            color: Colors.black),
                        Text("All BookMark"),
                      ],
                    )),
                PopupMenuItem(
                  value: Provider.of<ConnectivityProvider>(context,listen: false).selectedOption,
                  child: Row(
                    children: const [
                      Icon(Icons.laptop, color: Colors.black),
                      Text("Search Engine"),
                    ],
                  ),
                ),
              ],
            onSelected: (selectedOption) {
                Provider.of<ConnectivityProvider>(context,listen: false).selectedOption;
                if(selectedOption == "Option 1") {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            )
                                          )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                              ),
                                            ),
                                            Text(
                                              "Dismiss",
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              )
                            ],
                          ),
                        );
                      }
                  );
                } else if (selectedOption == "Option 2") {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Search Engine"),
                      )
                  );
                }
            },
          )
        ],
      ),
      body: (Provider.of<ConnectivityProvider>(context).connectivityModal.connectivityStatus == "waiting") ?
          Center(
            child: Column(
              children: const [
                SizedBox(
                  height: 250,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Check Internet Connection",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
          : Padding(padding: const EdgeInsets.all(16),
      child: Column(
          children: [
            Expanded(
                flex: 18,
                child: InAppWebView(
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) {
                    inAppWebViewController = controller;
                  },
                  onLoadStart: (controller , url) {
                    inAppWebViewController = controller;
                    Provider.of<ConnectivityProvider>(context).urlBookmark = url.toString();
                  },
                  onLoadStop: (controller , url) async {
                    await pullToRefreshController?.endRefreshing();
                  },
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(Url),
                  ),
                ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      String newLink = searchController.text;
                      inAppWebViewController?.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse("${Url}search?q=$newLink"),
                      )
                      );
                    },
                ),
              ),
            ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await  inAppWebViewController?.loadUrl(
                          urlRequest: URLRequest(
                          url: Uri.parse(Url),
                          ),
                          );
                        },
                        icon: Icon(
                         Icons.home
                        )
                    ),
                    IconButton(
                        onPressed: () async {
                          Provider.of<ConnectivityProvider>(context).
                          urlBookmark1.add(
                            await inAppWebViewController?.getUrl(),
                          );
                          print(await inAppWebViewController?.getUrl());
                        },
                      icon: Icon(
                        Icons.bookmark_add_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await inAppWebViewController!.canGoBack()) {
                          await inAppWebViewController?.goBack();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await inAppWebViewController?.reload();
                      },
                      icon: Icon(
                        Icons.refresh,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await inAppWebViewController!.canGoForward()) {
                          await inAppWebViewController?.goForward();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
            ))
          ],
      ),
      )
    );
  }
}
