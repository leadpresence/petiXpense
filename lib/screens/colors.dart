import '../imports.dart';

class ColorSelection{

   Color color;
   String name;
   ColorSelection({this.color, this.name});


 Color setColor(String color){
   switch(color) {
     case "Orange": {
       this.color=Color(0xFFFFC100);
     }
     break;
     case "White": {
       this.color=Color(0xFFffffff);
     }
     break;
     case "Cyan": {
       this.color=Color(0xFF00D1FF);
     }
     break;
     case "Green": {
       this.color=Color(0xFF73f09b);
     }
     break;
     case "Pink": {
       this.color=Color(0xFFeb88df);
     }
     break;
     case "Red": {
       this.color=Color(0xFFf73802);
     }
     break;


     default: {
       this.color=Color(0xFFffffff);
     }
     break;
   }
   return this.color;
  }
}