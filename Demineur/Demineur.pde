import processing.sound.*;
SoundFile file1;
SoundFile file2;
SoundFile file3;
SoundFile explosion;
SoundFile reussite;

/*file1 = new SoundFile(this, "musique1.mp3");
file2 = new SoundFile(this, "musique1.mp3");
file3 = new SoundFile(this, "musique1.mp3"); */

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
int passedTime;
int savedTime;
int musiqueTime;
int seconde;
int minute;
float volume = 1;

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
PImage fdmenu;
PImage victoire;
PImage gameOver;
PImage banniere;


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
  
  background(#000000);
  textSize(32);
  fill(0, 102, 153);
  text("Chargement...",485,350);
  PImage icon = loadImage("logo.png");
  surface.setIcon(icon);
  delay(1000);
  
  
  file1 = new SoundFile(this, "musique1.mp3");
   file2 = new SoundFile(this, "musique2.mp3");
   file3 = new SoundFile(this, "musique3.mp3");
   explosion = new SoundFile(this,"loose.mp3");
   reussite = new SoundFile(this,"victoire.mp3");
   debut(); //initialiser les images
   partie = 0; //envoyer vers le menu
   
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
    boutonQuitter(1140,20);
    quitter = true;
  } else if (partie == 0){ //Le joueur est dans le menu
    menu();
  } else if (partie == 3){ //Les resultat s'affiche
    //resultat
  } if (file1.isPlaying() == false && file2.isPlaying() == false && file3.isPlaying() == false && partie == 1 && millis() - musiqueTime > 10000){
    int musique = int(random(3));
  
    file1.stop();
    file2.stop();
    file3.stop();
    reussite.stop();
    musiqueTime = millis();
    delay(1000);
    if (musique == 0) file1.play();
    if (musique == 1) file2.play();
    if (musique == 2) file3.play();
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
  } else if (validation == true && mouseX > 40 && mouseX < (260+40) && mouseY > 50 && mouseY < (50+130)){
    println("ok");
    verification();
  }else if (quitter == true && mouseX > 1140 && mouseX < (1140+40) && mouseY > 20 && mouseY < (20+40)){
    partie = 0;
    quitter = false;
    println("quit");
  } else if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 200 && mouseY < (200+75)){
    println("facile");
    level = 0;
    debut();
  }else if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 350 && mouseY < (350+75)){
    println("moyen");
    level = 1;
    debut();
  }else if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 500 && mouseY < (500+75)){
    println("difficile");
    level = 2;
    debut();
  }else if (partie == 0 && mouseX > 500 && mouseX < (200+500) && mouseY > 650 && mouseY < (650+75)){
    println("quitter");
    exit();
  }else if (partie == 3 && mouseX > 200 && mouseX < (200+200) && mouseY > 580 && mouseY < (650+75)){
    println("recommencer");
    debut();
  }else if (partie == 3 && mouseX > 500 && mouseX < (200+500) && mouseY > 580 && mouseY < (650+75)){
    println("quitterPartie");
    partie = 0;
    quitter = false;
  }else if (partie == 3 && mouseX > 800 && mouseX < (200+800) && mouseY > 580 && mouseY < (650+75)){
    println("voir Resultat");
    partie = 4;
    background (gazon);
    afficherCase();
    image(quitterMenu, 920, 650);
  }else if (partie == 4 && mouseX > 920 && mouseX < (200+920) && mouseY > 650 && mouseY < (650+75)){
    println("quit Resultat");
    background (gazon);
    afficherCase();
    resultat(gagnerP);
  }else if (partie == 0 && mouseX > 1050 && mouseX < (100+1050) && mouseY > 200 && mouseY < (200+75)){
    volume(true);
  }else if (partie == 0 && mouseX > 1050 && mouseX < (100+1050) && mouseY > 300 && mouseY < (300+75)){
    volume(false);
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
    decalageX=325;
    decalageY =hauteurF/2-250;
  } else if (level == 2){
    largeur = 30;
    hauteur = 16;
    nbMines = 99;
    TX= 20;
    TY = 35;
    decalageX=310;
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
  
   fdmenu=loadImage("fdmenu2.jpg");
  fdmenu.resize(1200,750);
  fdmenu.loadPixels();
  
  quitterIm=loadImage("croix.png");
  quitterIm.resize(40,40);
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
  
  if (fond == 0) gazon = fd1;
  if (fond == 1) gazon = fd2;
  if (fond == 2) gazon = fd3;
  
  int musique = int(random(3));
  
  file1.stop();
  file2.stop();
  file3.stop();
  reussite.stop();
  
  musiqueTime = millis();
  
  
  
  delay(1000);
  
  if (musique == 0) file1.play();
  if (musique == 1) file2.play();
  if (musique == 2) file3.play();
  
  
  
  //leopaul
  
  preparerMines();
  savedTime = millis();
  seconde = 0;
  minute = 0;
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
  
    background(fdmenu);
  image(facile,500,200);
  image(moyen,500,350);
  image(difficile,500,500);
  image(quitterMenu,500,650);
  fill(#FFFFFF);
  triangle(1100,200,1050,275,1150,275);
  triangle(1100,375,1050,300,1150,300);
}

void boutonQuitter(int x, int y){ //Affiche le bouton Quitter
  image(quitterIm,x,y);
}

void resultat(boolean gagner){
  if (gagner == true){
    background(victoire); //image win
    if(minute == 0 && seconde == 0){
      file1.stop();
      file2.stop();
      file3.stop();
      reussite.play();
    }
  }
  if (gagner == false){
    background(gameOver); //image perdu
    if(minute == 0 && seconde == 0)    explosion.play();
  }
  gagnerP = gagner;
  partie = 3;
  if(minute == 0 && seconde == 0){
    passedTime = millis()- savedTime; //on arrete le timer
    println(savedTime);
    println(passedTime);
    seconde = passedTime / 1000;
    minute = seconde / 60;
    seconde = seconde % 60;
  }
  textSize(41);
  fill(#FFFFFF);
  text("Timer:",1050,200);
  text(minute + "min " + seconde + "s", 1010, 300);
  for (int i = 0; i < largeur; i++){
    for(int j = 0; j < hauteur; j++){
      if (cache[i][j] == 9){
        
       
        if (visible[i][j] == 11){
          visible[i][j] = 12;
          cache[i][j] = 12;//mine en jaune
         
        } else {
          visible[i][j] = 9;
        }
      }
    }
  }
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

void volume(boolean monter){
  if (monter == true && volume < 1){
    volume = volume + 0.1;
    file1.amp(volume);
    file2.amp(volume);
    file3.amp(volume);
    reussite.amp(volume);
    explosion.amp(volume);
  } else if (monter == false && volume > 0){
    volume = volume - 0.1;
    file1.amp(volume);
    file2.amp(volume);
    file3.amp(volume);
    reussite.amp(volume);
    explosion.amp(volume);
  }
}