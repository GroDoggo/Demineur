////////////////////
//Afficher Damier///
////////////////////

int [][] cache = new int[100][100];
    
    
int nbMines;
int level = 0;
int hauteur;
int largeur;
int ligne = 0;
int colonne = 0;
int num = 0;
int numDrapeau = 0;
boolean validation = false;
boolean quitter = false; //Vaut true quand le bouton est affiché
int partie = 0; //0 => menu; 1 => en partie; 3 => résultat
boolean gagnerP = true;

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
PImage gazon;
PImage goldMine;
PImage quitterIm;
PImage facile;
PImage moyen;
PImage difficile;
PImage quitterMenu;
PImage recommencer;
PImage voirR;
PImage fd1;
PImage fd2;
PImage fd3;
PImage victoire;
PImage gameOver;

int TX= 50;
int TY = 50;
int largeurF =1200;
int hauteurF =750;
int decalageX=largeurF/2-250;
int decalageY =hauteurF/2-250;

int [][] visible = new int[100][100];  
//Méthode qui s'éxecute au démarrage

void setup ()
{
  size (1200,750); 
  background (#000080);
  debut();
  partie = 0;
}


/* la méthode qui s'exécute en boucle */
void draw()
{
  if (partie == 1){ //Le joueur est dans une partie
    background (gazon);
    afficherCase ();
    if(numDrapeau == nbMines){
      boutonOK();
      validation = true;
    } else {
      validation = false;
    }
    boutonQuitter(900,10);
    quitter = true;
  } else if (partie == 0){ //Le joueur est dans le menu
    menu();
  } else if (partie == 3){ //Les resultat s'affiche
    //resultat
  }
}


void mousePressed() {
  int i = (mouseX - decalageX) / TX;
  int j = (mouseY - decalageY) / TY;
  if (i >= 0 && i < largeur && j >= 0 && j < hauteur && partie == 1){
    if(mouseButton == LEFT){
      if (visible[i][j] != 11) visible[i][j]=cache[i][j]; //Si il n'y a pas de drapeau la case se révèle
      if (cache[i][j] == 0){
        visible[i][j] = 10; //Affiche une case vide
        caseBlanche(i,j);
      }
      if (cache[i][j] == 9){
        afficherCase();
        resultat(false);
      }
    } else if(mouseButton == RIGHT){
      if (visible[i][j] == 11){
        visible[i][j] = 0;
        numDrapeau--;//enleve le drapeau si il y en a 1
      }else if(visible[i][j] == 0 & numDrapeau < nbMines){                        
        visible[i][j] = 11;
        numDrapeau++;//place un drapeau si la case n'a pas été découverte
      }
    }
  }
  if (validation == true && mouseX > 40 && mouseX < (260+40) && mouseY > 50 && mouseY < (50+130)){
    println("ok");
    verification();
  }
  if (quitter == true && mouseX > 900 && mouseX < (260+900) && mouseY > 10 && mouseY < (10+130)){
    partie = 0;
    quitter = false;
    println("quit");
  }
  if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 10 && mouseY < (10+75)){
    println("facile");
    level = 0;
    debut();
  }
  if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 200 && mouseY < (200+75)){
    println("moyen");
    level = 1;
    debut();
  }
  if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 390 && mouseY < (390+75)){
    println("difficile");
    level = 2;
    debut();
  }
  if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 580 && mouseY < (580+75)){
    println("quitter");
    exit();
  }
  if (partie == 3 && mouseX > 200 && mouseX < (200+200) && mouseY > 580 && mouseY < (650+75)){
    println("recommencer");
    debut();
  }
  if (partie == 3 && mouseX > 500 && mouseX < (200+500) && mouseY > 580 && mouseY < (650+75)){
    println("quitterPartie");
    partie = 0;
    quitter = false;
  }
  if (partie == 3 && mouseX > 800 && mouseX < (200+800) && mouseY > 580 && mouseY < (650+75)){
    println("voir Resultat");
    partie = 4;
    background (gazon);
    afficherCase();
    image(quitterMenu, 900, 650);
  }
  if (partie == 4 && mouseX > 900 && mouseX < (200+900) && mouseY > 580 && mouseY < (650+75)){
    println("quit Resultat");
    background (gazon);
    afficherCase();
    resultat(gagnerP);
  }
}

void preparerMines(){
  //Mettre tout a 0
  for (int j = 0; j < hauteur ;j++){
    for (int i = 0; i < largeur; i++){
      cache[i][j] = 0;
      visible[i][j] = 0;
    }
  }
  //Poser les mines
  for (int i=0; i < nbMines ; i++) //Les mines sont disposés aléatoirement
  {
    ligne = int(random(largeur));
    colonne = int(random(hauteur));
    if (cache[ligne][colonne] == 9){
      i--;
    } else {
      cache[ligne][colonne] = 9;
    }
  }
  //On determine les chiffres
  for (int i = 0 ; i < largeur ; i++){ //ligne
    for(int j = 0; j < hauteur; j++){  //colonne
      num = 0;
      if (i != 0 && j != 0){
         if (cache[i-1][j-1] == 9) num++;
      }
      if (j != 0){
         if (cache[i][j-1] == 9) num++;
      }
      if (i != (largeur-1) && j != 0){
         if (cache[i+1][j-1] == 9) num++;
      }
      if (i != 0){
         if (cache[i-1][j] == 9) num++;
      }
      if (i !=(largeur-1)){
         if (cache[i+1][j] == 9) num++;
      }
      if (i != 0 && j != (hauteur-1)){
         if (cache[i-1][j+1] == 9) num++;
      }
      if (j != 9){
         if (cache[i][j+1] == 9) num++;
      }
      if (i != (largeur-1) && j != (hauteur-1)){
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
for (int i = 0; i < largeur; i++){
    for(int j = 0; j < hauteur; j++){
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
        
     if (visible[i][j] == 12){
        image(goldMine, i*TX+decalageX, j*TY+decalageY);
    }
    }
  }
  
}

void boutonOK(){
 
  image(valider,40,50);
}

void difficulte(){
  if (level == 0){
    largeur = 10;
    hauteur = 10;
    nbMines = 10;
    TX= 50;
    TY = 50;
    decalageX=largeurF/2-250;
    decalageY =hauteurF/2-250;
  } else if (level == 1){
    largeur = 16;
    hauteur = 16;
    nbMines = 40;
    TX= 35;
    TY = 35;
    decalageX=largeurF/2-350;
    decalageY =hauteurF/2-250;
  } else if (level == 2){
    largeur = 30;
    hauteur = 16;
    nbMines = 99;
    TX= 20;
    TY = 35;
    decalageX=largeurF/2-350;
    decalageY =hauteurF/2-250;
  }
}

void verification(){
  boolean gagner = true;
  for (int i = 0; i < largeur; i++){
    for(int j = 0; j < hauteur; j++){
      if (cache[i][j] == 9){
        
       
        if (visible[i][j] == 11){
          visible[i][j] = 12;
          cache[i][j] = 12;//mine en jaune
         
        } else {
          visible[i][j] = 9;
          gagner = false;
        }
      }
    }
  }
  afficherCase(); 
  resultat(gagner);
}

void debut(){
  
  difficulte();
  //Sylvain
  caseVide=loadImage("caseVide (2).PNG");
  caseVide.resize(TX,TY);
  caseVide.loadPixels();
  case1=loadImage("1.PNG");
   case1.resize(TX,TY);
  case1.loadPixels();
  
  caseVideOuverte=loadImage("caseVideOuverte (2).png");
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
  
   goldMine=loadImage("goldMine.png");
   goldMine.resize(TX,TY);
  goldMine.loadPixels();
  
  valider=loadImage("valider.png");
  valider.resize(260,130);
  valider.loadPixels();
  
  fd1=loadImage("fd1.jpg");
  fd1.resize(1200,750);
  fd1.loadPixels();
  
  fd2=loadImage("fd2.jpg");
  fd2.resize(1200,750);
  fd2.loadPixels();
  
  fd3=loadImage("fd3.jpg");
  fd3.resize(1200,750);
  fd3.loadPixels();
  
  quitterIm=loadImage("quitter.png");
  quitterIm.resize(260,130);
  quitterIm.loadPixels();
  
  facile=loadImage("facile.png");
  facile.resize(200,75);
  facile.loadPixels();

  moyen=loadImage("moyen.png");
  moyen.resize(200,75);
  moyen.loadPixels();

  difficile=loadImage("difficile.png");
  difficile.resize(200,75);
  difficile.loadPixels();

  quitterMenu=loadImage("quitter_menu.png");
  quitterMenu.resize(200,75);
  quitterMenu.loadPixels();
  
  recommencer=loadImage("recommencer.png");
  recommencer.resize(200,75);
  recommencer.loadPixels();
  
  voirR=loadImage("voirR.png");
  voirR.resize(200,75);
  voirR.loadPixels();
  
  victoire=loadImage("victoire.jpg");
  victoire.resize(1200,750);
  victoire.loadPixels();
  
  gameOver=loadImage("gamOver.jpg");
  gameOver.resize(1200,750);
  gameOver.loadPixels();
  
  int fond = int(random(3));
  
  if (fond == 1) gazon = fd1;
  if (fond == 0) gazon = fd2;
  if (fond == 2) gazon = fd3;
  
  //leopaul
  
  preparerMines();
  partie = 1;
  numDrapeau = 0;
  for (int j = 0 ; j < hauteur ; j++){
    println();
    for(int i = 0; i < largeur; i++){
      print(cache[i][j]);
    }
  }
}

void menu(){
  
    background(#cdcac9);
  image(facile,500,10);
  image(moyen,500,200);
  image(difficile,500,390);
  image(quitterMenu,500,580);
  
}

void boutonQuitter(int x, int y){ //Affiche le bouton Quitter
  image(quitterIm,x,y);
}

void resultat(boolean gagner){
  if (gagner == true) background(victoire); //image win
  if (gagner == false) background(gameOver); //image perdu
  gagnerP = gagner;
  partie = 3;
  image(recommencer, 200, 650);
  image(quitterMenu, 500, 650);
  image(voirR, 800, 650);
}

void caseBlanche(int x, int y)
{
  
  if (x != 0 && y != 0){
      if (cache[x-1][y-1] == 0 && visible[x-1][y-1] == 0){
           visible[x-1][y-1] = 10;
           caseBlanche(x-1,y-1);
           
      } else if (cache[x-1][y-1] != 9 && visible[x-1][y-1] == 0){
        visible[x-1][y-1] = cache[x-1][y-1];
      }
  }
  if (y != 0){
     if (cache[x][y-1] == 0 && visible[x][y-1] == 0) {
         visible[x][y-1] = 10;
         caseBlanche(x,y-1);
         
     } else if (cache[x][y-1] != 9 && visible[x][y-1] == 0){
        visible[x][y-1] = cache[x][y-1];
      }
  }
  if (x != (largeur-1) && y != 0){
     if (cache[x+1][y-1] == 0 && visible[x+1][y-1] == 0){
       visible[x+1][y-1] = 10;
       caseBlanche(x+1,y-1);
       
     } else if (cache[x+1][y-1] != 9 && visible[x+1][y-1] == 0){
        visible[x+1][y-1] = cache[x+1][y-1];
      }
  }
  if (x != 0){
     if (cache[x-1][y] == 0 && visible[x-1][y] == 0){
       visible[x-1][y] = 10;
       caseBlanche(x-1,y);
       
     } else if (cache[x-1][y] != 9 && visible[x-1][y] == 0){
        visible[x-1][y] = cache[x-1][y];
      }
  }
  if (x !=(largeur-1)){
     if (cache[x+1][y] == 0 && visible[x+1][y] == 0){
       visible[x+1][y] = 10;
       caseBlanche(x+1,y);
      
     } else if (cache[x+1][y] != 9 && visible[x+1][y] == 0){
        visible[x+1][y] = cache[x+1][y];
      }
  }
  if (x != 0 && y != (hauteur-1)){
     if (cache[x-1][y+1] == 0 && visible[x-1][y+1] == 0){
       visible[x-1][y+1] = 10;
       caseBlanche(x-1,y+1);
      
     } else if (cache[x-1][y+1] != 9 && visible[x-1][y+1] == 0){
        visible[x-1][y+1] = cache[x-1][y+1];
      }
  }
  if (y != (hauteur - 1)){
     if (cache[x][y+1] == 0 && visible[x][y+1] == 0){
       visible[x][y+1] = 10;
       caseBlanche(x,y+1);
       
     }else if (cache[x][y+1] != 9 && visible[x][y+1] == 0){
        visible[x][y+1] = cache[x][y+1];
      }
  }
  if (x != (largeur-1) && y != (hauteur-1)){
     if (cache[x+1][y+1] == 0 && visible[x+1][y+1] == 0){
       visible[x+1][y+1] = 10;
       caseBlanche(x+1,y+1);
       
     } else if (cache[x+1][y+1] != 9 && visible[x+1][y+1] == 0){
        visible[x+1][y+1] = cache[x+1][y+1];
      }
  }
}