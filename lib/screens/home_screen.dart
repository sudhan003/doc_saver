import 'package:doc_saver/all_imports.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  StreamController<DatabaseEvent> streamController = StreamController();

  setStream() {
    String user = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance
        .ref()
        .child('files_info/$user')
        .startAt(searchController.text)
        .endAt("${searchController.text}" "\uf8ff")
        .orderByChild('title')
        .onValue
        .listen((event) {
      streamController.add(event);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStream();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: CustomFloatingActionButton(
            title: 'add',
            iconData: Icons.add,
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, AddFileScreen.routeName);
            },
          ),
          appBar: CustomHomeAppBar(
            controller: searchController,
            onSearch: () {
              setStream();
            },
          ),
          body: ScreenBackgroundWidget(
            child: StreamBuilder<DatabaseEvent>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    List<FileCardModel> list = [];
                    (snapshot.data!.snapshot.value as Map<dynamic, dynamic>)
                        .forEach((key, value) {
                      list.add(FileCardModel.fromJson(value, key));
                      print(value);
                      print(key);
                    });

                    return ListView(
                        children: list
                            .map(
                              (e) => FileCard(
                                model: FileCardModel(
                                  id: e.id,
                                  title: e.title,
                                  subTitle: e.subTitle,
                                  date: e.date,
                                  fileType: e.fileType,
                                  fileUrl: e.fileUrl,
                                  fileName: e.fileName,
                                ),
                              ),
                            )
                            .toList());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/icon_no_file.png',
                            height: 70,
                          ),
                          SizedBoxHelper.sizedBox10,
                          const Text(
                            'No Data found',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          )),
    );
  }
}
