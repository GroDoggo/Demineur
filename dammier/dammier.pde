////////////////////
//Afficher Damier///
////////////////////

int [][] cache = //le joueur ne voit pas
  { {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0} };
int nbMines = 10;
int ligne = 0;
int colonne = 0;
int num = 0;
int numDrapeau = 0;

PImage caseVide;
PImage caseVideOuverte;
PImage case1;
PImage case2;
PImage case3;
PImage case4;
PImage case5;
PImage case6;
PImage case7;
PImage case8;
PImage drapeau;
PImage mine;
PImage valider;

int TX= 50;
int TY = 50;
int largeurF =1200;
int hauteurF =750;
int decalageX=largeurF/2-250;
int decalageY =hauteurF/2-250;

int [][] visible = 

  { {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0},

    {0,0,0,0,0,0,0,0,0,0} };
    
    
  
  

    
//Méthode qui s'éxecute au démarrage

void setup ()
{
  size (1200,750); 
  background (#000080);
  //Sylvain
  caseVide=loadImage("caseVide.PNG");
  caseVide.resize(TX,TY);
  caseVide.loadPixels();
  case1=loadImage("1.PNG");
   case1.resize(TX,TY);
  case1.loadPixels();
  
  caseVideOuverte=loadImage("caseVideOuverte.png");
  caseVideOuverte.resize(TX,TY);
  caseVideOuverte.loadPixels();
  
   case2=loadImage("2.PNG");
   case2.resize(TX,TY);
  case2.loadPixels();

   case3=loadImage("3.PNG");
   case3.resize(TX,TY);
  case3.loadPixels();

   case4=loadImage("4.PNG");
   case4.resize(TX,TY);
  case4.loadPixels();

   case5=loadImage("5.PNG");
   case5.resize(TX,TY);
  case5.loadPixels();

   case6=loadImage("6.PNG");
   case6.resize(TX,TY);
  case6.loadPixels();

   case7=loadImage("7.PNG");
   case7.resize(TX,TY);
  case7.loadPixels();

   case8=loadImage("8.PNG");
   case8.resize(TX,TY);
  case8.loadPixels();
  
  drapeau=loadImage("drapeau.png");
   drapeau.resize(TX,TY);
  drapeau.loadPixels();

   mine=loadImage("mine.png");
   mine.resize(TX,TY);
  mine.loadPixels();
  
  valider=loadImage("valider.png");
  valider.resize(260,130);
  valider.loadPixels();
  
  //leopaul
  preparerMines();
  for (int j = 0 ; j < 10 ; j++){
    println();
    for(int i = 0; i< 10; i++){
      print(cache[i][j]);
    }
  }
 
}


/* la méthode qui s'exécute en boucle */
void draw()
{
  background (#000080);
  afficherCase ();
    if(numDrapeau == nbMines){
    boutonOK();
  }
}


void mousePressed() {
  //visible[3][2] = 1; 
  int i = (mouseX - decalageX) / TX;
  int j = (mouseY - decalageY) / TY;
  if (i >= 0 && i < 10 && j >= 0 && j < 10){
    if(mouseButton == LEFT){
      if (visible[i][j] != 11) visible[i][j]=cache[i][j]; //Si il n'y a pas de drapeau la case se révèle
      if (cache[i][j] == 0) visible[i][j] = 10; //Affiche une case vide
    } else if(mouseButton == RIGHT){
      println("right");
      println(i);
      println(j);
       if (visible[i][j] == 11){
        visible[i][j] = 0;
        numDrapeau--;//enleve le drapeau si il y en a 1
      }else if(visible[i][j] == 0 & numDrapeau <10){                        
        visible[i][j] = 11;
        numDrapeau++;//place un drapeau si la case n'a pas été découverte
      }


    }
  }
}

void preparerMines(){
  for (int i=0; i < nbMines ; i++) //Les mines sont disposés aléatoirement
  {
    ligne = int(random(10));
    colonne = int(random(10));
    if (cache[ligne][colonne] == 9){
      i--;
    } else {
      cache[ligne][colonne] = 9;
    }
  }
  //On determine les chiffres
  for (int i = 0 ; i < 10 ; i++){ //ligne
    for(int j = 0; j< 10; j++){  //colonne
      num = 0;
      if (i != 0 && j != 0){
         if (cache[i-1][j-1] == 9) num++;
      }
      if (j != 0){
         if (cache[i][j-1] == 9) num++;
      }
      if (i != 9 && j != 0){
         if (cache[i+1][j-1] == 9) num++;
      }
      if (i != 0){
         if (cache[i-1][j] == 9) num++;
      }
      if (i !=9){
         if (cache[i+1][j] == 9) num++;
      }
      if (i != 0 && j != 9){
         if (cache[i-1][j+1] == 9) num++;
      }
      if (j != 9){
         if (cache[i][j+1] == 9) num++;
      }
      if (i != 9 && j != 9){
         if (cache[i+1][j+1] == 9) num++;
      }
      if (cache[i][j] != 9){
        cache[i][j] = num;
      }
    }
  }
}

void afficherCase()
{
for (int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      if (visible[i][j] == 0){
        image(caseVide, i*TX + decalageX, j*TY+decalageY);
      }
      if (visible[i][j] == 1){
        image(case1, i*TX+decalageX, j*TY+decalageY);
      }
       if (visible[i][j] == 2){
        image(case2, i*TX+decalageX, j*TY+decalageY);
      }
      if (visible[i][j] == 3){
        image(case3, i*TX+decalageX, j*TY+decalageY);
      }

      if (visible[i][j] == 4){
        image(case4, i*TX+decalageX, j*TY+decalageY);
      }

      if (visible[i][j] == 5){
        image(case5, i*TX+decalageX, j*TY+decalageY);
      }

      if (visible[i][j] == 6){
        image(case6, i*TX+decalageX, j*TY+decalageY);
      }

      if (visible[i][j] == 7){
        image(case7, i*TX+decalageX, j*TY+decalageY);
      }

      if (visible[i][j] == 8){
        image(case8, i*TX+decalageX, j*TY+decalageY);
      }
      
       if (visible[i][j] == 10){
        image(caseVideOuverte, i*TX+decalageX, j*TY+decalageY);
    }

      if (visible[i][j] == 11){
        image(drapeau, i*TX+decalageX, j*TY+decalageY);
    }

     if (visible[i][j] == 9){
        image(mine, i*TX+decalageX, j*TY+decalageY);
    }
    }
  }
  
}

void boutonOK(){
  /*fill(#16A707);
  rect(10,10,175,50);
  fill(#000000);
  textSize(40);
  text("VALIDER",15,50);*/
  image(valider,40,50);
}