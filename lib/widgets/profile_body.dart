
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two/constants/common_size.dart';
import 'package:instagram_two/constants/screen_size.dart';
import 'package:instagram_two/screens/profile_screen.dart';
import 'package:instagram_two/widgets/rounded_avator.dart';

class ProfileBody extends StatefulWidget {

  final Function onMenuChanged;
  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
    _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPagesMargin = 0;
  double _rightImagesPagesMargin = size.width;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController = AnimationController(vsync: this, duration : duration);
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            _appBar(),
            Expanded(
              child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                          [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(common_gap),
                                  child: RoundedAvatar(
                                    size: 80,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: common_gap),
                                    child: Table(
                                      children: [
                                        TableRow(
                                            children: [
                                              _valueText('123123'),
                                              _valueText('123123'),
                                              _valueText('123123'),
                                            ]
                                        ),
                                        TableRow(
                                            children: [
                                              _labelText('Post'),
                                              _labelText('Followers'),
                                              _labelText('Following'),
                                            ]
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            _username(),
                            _userBio(),
                            _editProfileBtn(),
                            _tabButtons(),
                            _selectedIndicator()
                          ]
                      ),
                    ),
                    _imagesPager()
                  ]
              ),
            )
          ],
        )
    );
  }

  Row _appBar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
                'The Coding Papa',
                textAlign: TextAlign.center
            )
        ),
        IconButton(
          icon : AnimatedIcon(icon : AnimatedIcons.menu_close, progress: _iconAnimationController,),
          onPressed: () {
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed ?
                _iconAnimationController.reverse()
                : _iconAnimationController.forward();
          },
        )
      ],
    );
  }

  Text _valueText(String value) => Text(
    value,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontWeight: FontWeight.bold
    )
  );
  Text _labelText(String label) => Text(
    label,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 11
    ),
  );




  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: duration,
                    transform: Matrix4.translationValues(_leftImagesPagesMargin, 0, 0),
                    curve: Curves.fastOutSlowIn,
                    child: _images(),
                  ),
                  AnimatedContainer(
                    duration: duration,
                    transform: Matrix4.translationValues(_rightImagesPagesMargin, 0, 0),
                    curve: Curves.fastOutSlowIn,
                    child: _images(),
                  ),
                ],
              )
          );
  }

  GridView _images() {
    return GridView.count(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 3,
    childAspectRatio: 1,
    children: List.generate(30, (index) => CachedNetworkImage(
            fit : BoxFit.cover,
            imageUrl: 'https://picsum.photos/id/$index/100/100')
    ));
  }

  Widget _selectedIndicator(){
    return AnimatedContainer(
      duration : duration,
      alignment: _selectedTab==SelectedTab.left?Alignment.centerLeft:Alignment.centerRight,
      child: Container(height: 3 , width: size.width/2, color: Colors.black87),
      curve: Curves.easeInOutSine,
    );
  }

  Row _tabButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(child:
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/grid.png'),
              color: _selectedTab==SelectedTab.left?Colors.black:Colors.black26,
            ),
            onPressed: (){
              _tabSelected(SelectedTab.left);
            },
          ),
        ),
        Expanded(child:
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/saved.png'),
              color: _selectedTab==SelectedTab.left?Colors.black26:Colors.black,
            ),
            onPressed: (){
              _tabSelected(SelectedTab.right);
            },
          ),
        )
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch(selectedTab){
        case SelectedTab.left:
            _selectedTab = SelectedTab.left;
            _leftImagesPagesMargin = 0;
            _rightImagesPagesMargin = size.width;
          break;
        case SelectedTab.right:
            _selectedTab = SelectedTab.right;
            _leftImagesPagesMargin = -size.width;
            _rightImagesPagesMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap , vertical: common_xss_gap),
      child: SizedBox(
          height: 24,
          child: OutlineButton(
              onPressed: (){},
              borderSide: BorderSide(
                color: Colors.black45,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
              )
          )
      ),
    );
  }

  Widget _username(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
          'username',
          style: TextStyle(
              fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _userBio(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
          'this is what I belive!!',
          style: TextStyle(
              fontWeight: FontWeight.w400)
      ),
    );
  }




}

enum SelectedTab{
  left, right
}