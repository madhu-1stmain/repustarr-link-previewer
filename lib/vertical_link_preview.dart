part of link_previewer;

class VerticalLinkPreview extends StatelessWidget {
  VerticalLinkPreview({
    Key key,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.imageUri,
    @required this.onTap,
    this.titleFontSize,
    this.bodyFontSize,
    this.showTitle,
    this.showBody,
    this.bodyTextOverflow,
    this.bodyMaxLines,
  })  : assert(imageUri != null),
        assert(title != null),
        assert(url != null),
        assert(description != null),
        assert(onTap != null),
        super(key: key);

  final String url;
  final String title;
  final String description;
  final String imageUri;
  final Function onTap;
  final double titleFontSize;
  final double bodyFontSize;
  final bool showTitle;
  final bool showBody;
  final TextOverflow bodyTextOverflow;
  final int bodyMaxLines;

  double computeTitleFontSize(double height) {
    double size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight, layoutWidth) {
    return layoutHeight - layoutWidth < 50 ? 1 : 2;
  }

  int computeBodyLines(layoutHeight) {
    return layoutHeight ~/ 60 == 0 ? 1 : layoutHeight ~/ 60;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var _titleFontSize = titleFontSize == null
          ? computeTitleFontSize(layoutHeight)
          : titleFontSize;
      var _bodyFontSize = bodyFontSize == null
          ? computeTitleFontSize(layoutHeight) - 1
          : bodyFontSize;

      return InkWell(
          onTap: () => onTap(url),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: imageUri == ""
                    ? Container(
                        color: Colors.grey,
                      )
                    : Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(imageUri),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
              ),
              showTitle == false
                  ? Container()
                  : _buildTitleContainer(_titleFontSize,
                      computeTitleLines(layoutHeight, layoutWidth)),
              showBody == false
                  ? Container()
                  : _buildBodyContainer(
                      _bodyFontSize, computeBodyLines(layoutHeight)),
            ],
          ));
    });
  }

  Widget _buildTitleContainer(_titleFontSize, _maxLines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 1.0),
      child: Container(
        alignment: Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _titleFontSize,
              ),
              // overflow: TextOverflow.ellipsis,
              // maxLines: _maxLines,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContainer(_bodyFontSize, _maxLines) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 5.0),
        child: Container(
          alignment: Alignment(-1.0, -1.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: _bodyFontSize,
              color: Colors.grey,
            ),
            maxLines: null,
            // overflow:
            //     bodyTextOverflow == null ? TextOverflow.fade : bodyTextOverflow,
            // maxLines: bodyMaxLines == null ? _maxLines : bodyMaxLines,
          ),
        ),
      ),
    );
  }
}
