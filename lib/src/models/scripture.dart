/*[
{"bookname":"Psalms",
"chapter":"10",
"verse":"9",
"text":"He lies in ambush in a hidden place, like a lion in a thicket; he lies in ambush, waiting to catch the oppressed;he catches the oppressed by pulling in his net. "
}
]*/

class Scripture {
  String bookName, chapter, verse, text;

  Scripture({this.bookName, this.chapter, this.verse, this.text});

  factory Scripture.fromJson(Map<String, dynamic> json) {
    return Scripture(
        bookName: json['bookname'],
        chapter: json['chapter'],
        verse: json['verse'],
        text: json['text']);
  }
}