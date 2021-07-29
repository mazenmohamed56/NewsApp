import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/search/searchScreen.dart';
import 'package:news_app/modules/webView/wibViewScreen.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget aticleBuildItem({@required Map article, context}) => InkWell(
      onTap: () {
        navigateTo(context, ArticleWebView(article['url']));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          width: 150,
          height: 130,
          child: Row(
            children: [
              Image(
                width: 150,
                height: 130,
                fit: BoxFit.cover,
                image: NetworkImage('${article['urlToImage']}'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${article['publishedAt']},',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
Widget articlesBuilder({@required List list, context, bool isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (BuildContext context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              aticleBuildItem(article: list[index], context: context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 10.0, start: 20, bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[500],
                ),
              ),
          itemCount: list.length),
      fallback: (context) =>
          isSearch ? Container() : Center(child: CircularProgressIndicator()),
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
