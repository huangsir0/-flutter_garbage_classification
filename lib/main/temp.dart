//Scaffold(
//appBar: AppBar(
//title: Text("首页"),
//),
//body: Container(
//width: double.infinity,
//padding: EdgeInsets.all(10),
//child: SingleChildScrollView(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
//children: <Widget>[
//InkWell(
//child: Container(
//height: 40,
//alignment: Alignment.center,
//width: 200,
//decoration: BoxDecoration(
//borderRadius: BorderRadius.circular(10),
//border: Border.all(
//color: Theme.of(context).primaryColor, width: 1)),
//child: Text(
//"查询",
//style: TextStyle(
//letterSpacing: 5,
//fontSize: 18,
//color: Theme.of(context).primaryColor),
//),
//),
//onTap: () {
//_homePageBloc.fetchGarabe("烟头");
//},
//),
//Container(
//height: 80,
//width: 120,
//margin: EdgeInsets.only(top: 10),
//child: StreamBuilder(
//builder: (BuildContext context,
//    AsyncSnapshot<GarbageInfo> shot) {
//if (shot.hasData) {
//print("msg===>"+shot.data.imgUrl);
//
//return Center(
//child: Image.network("https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=ff51421a56afa40f28cbc68fca0d682a/023b5bb5c9ea15ceba721521ba003af33a87b27e.jpg"),
//);
//return CachedNetworkImage(
//imageUrl: "http://img3.imgtn.bdimg.com/it/u=849978245,899449678&fm=26&gp=0.jpg",//shot.data.imgUrl,
//fit: BoxFit.cover,
//);
//} else {
//return Container();
//}
//},
//stream: _homePageBloc.gabageSearch,
//),
//)
//],
//),
//),
//))