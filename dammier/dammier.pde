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

PImage caseVide;
PImage case1;
int TX= 50;
int TY = 50;
int largeurF =1200;
int hauteurF =750;
int decalageX=largeurF/2;
int decalageY =hauteurF/2;

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
  background (#FFFFFF);
  //Sylvain
  caseVide=loadImage("caseVide.PNG");
  caseVide.resize(TX,TY);
  caseVide.loadPixels();
  case1=loadImage("1.PNG");
   case1.resize(TX,TY);
  case1.loadPixels();
  //leopaul
  preparerMines();
  for (int i = 0 ; i < 10 ; i++){
    println();
    for(int j = 0; j< 10; j++){
      print(cache[i][j]);
    }
  }
 
}


/* la méthode qui s'exécute en boucle */
void draw()
{
  afficherCase ();
}


void mousePressed() {
  visible[3][2] = 1; 
  caseClic();
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
  //On determine les chiifres
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
    }
  }
  
}

void caseClic(){
  int i = (mouseX - decalageX) / TX;
  int j = (mouseY - decalageY) / TY;
  print(i);
  println(j);
}