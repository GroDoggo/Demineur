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
boolean menu1 = false;
int partie = 0; //0 => menu; 1 => en partie; 2 => perdu ; 3 => gagné

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
PImage facile;
PImage moyen;
PImage difficile;
PImage quitterMenu;

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
  } else if (partie == 0){
    menu();
  }
}


void mousePressed() {
  int i = (mouseX - decalageX) / TX;
  int j = (mouseY - decalageY) / TY;
  if (i >= 0 && i < largeur && j >= 0 && j < hauteur){
    if(mouseButton == LEFT){
      if (visible[i][j] != 11) visible[i][j]=cache[i][j]; //Si il n'y a pas de drapeau la case se révèle
      if (cache[i][j] == 0) visible[i][j] = 10; //Affiche une case vide
      if (cache[i][j] ==9) image(drapeau,100,500);
    } else if(mouseButton == RIGHT){
      println("right");
      println(i);
      println(j);
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
    println("facile");
    level = 2;
    debut();
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
  } else if (level == 1){
    largeur = 16;
    hauteur = 16;
    nbMines = 40;
    TX= 35;
    TY = 35;
  } else if (level == 2){
    largeur = 30;
    hauteur = 16;
    nbMines = 99;
    TX= 20;
    TY = 35;
  }
}

void verification(){
  for (int i = 0; i < largeur; i++){
    for(int j = 0; j < hauteur; j++){
      if (cache[i][j] == 9){
        
       
        if (visible[i][j] == 11){
          visible[i][j] = 12;
          cache[i][j] = 12;//mine en jaune
         
        } else {
          visible[i][j] = 9;
          partie = 2;
        }
      }
    }
  }
  afficherCase();
  if (partie == 1){
    //Afficher GAGNE
  }
}



void debut(){
  
  difficulte();
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
  
   goldMine=loadImage("goldMine.png");
   goldMine.resize(TX,TY);
  goldMine.loadPixels();
  
  valider=loadImage("valider.png");
  valider.resize(260,130);
  valider.loadPixels();
  
  gazon=loadImage("gazon.png");
  gazon.loadPixels();
  
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