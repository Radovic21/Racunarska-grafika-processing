PImage block;
PImage mina;
PImage zastava_flag;
ArrayList<PImage> br = new ArrayList<PImage>();

int povrsina_kockice = 16;   //int boxSize = 17 ; menja velicinu table za igranje tj povrsinu ali sama kockica zauzemu odredjenu 
int duzina_tabele_polja = 30;
int Polja_ostalo_levo;       // broj ostalih- neotvorenih polja 
int Flagova_ostalo;             // flagovi 

boolean Mrtav = false;
boolean Mrtav_sledeci_Frame = true;         //moguce vrednosti ...
boolean Pobeda = false;
boolean Pobeda_sledeci_Frame = false;

Minsko_polje Polje;             

void setup(){
  frameRate(60);                      
  
  Polje = new Minsko_polje();                    // poziv iz minefield clase da bi se napravilo celo polje 30x30
  
  block = loadImage("block.png");                   //ucitavanje slika 
  mina = loadImage("mine.png");
  zastava_flag = loadImage("flagged.png");
  for(int i = 0; i < 9; i++){
    String ime = str(i);
    ime += ".png";                                 //preko Stringa 
    br.add(loadImage(ime));
  }
}

void draw(){                                                                          
  Flagova_ostalo = duzina_tabele_polja * 4;                                      //flagovi 120  duzina tabele 30*4,
  Polja_ostalo_levo = duzina_tabele_polja * duzina_tabele_polja;                 //tabela 30*30 
  
  if(!Mrtav && !Pobeda){                             
    settings();
    background(255);
    for(int i = 0; i < duzina_tabele_polja; i++){
      for(int j = 0; j < duzina_tabele_polja; j++){
        if(Polje.ne_ukljuceno[i][j] == 1){
          Polja_ostalo_levo--;
          if(Polje.polje_matrica[i][j] == -1){
            image(mina, j * povrsina_kockice, i * povrsina_kockice);
          }
          else{
            image(br.get(Polje.Bomba_oko_mene(i, j)), j * povrsina_kockice, i * povrsina_kockice);
          }
        }
        else if(Polje.ne_ukljuceno[i][j] == 2){
          image(zastava_flag, j * povrsina_kockice, i * povrsina_kockice);
          Polja_ostalo_levo--;
          Flagova_ostalo--;
        }
        else{
          image(block, j * povrsina_kockice, i * povrsina_kockice);
        }
      }
    }
    fill(0);
    textSize(15);
    text("Polja  : " + Polja_ostalo_levo, 5, povrsina_kockice * duzina_tabele_polja + 20);               // koliko je polja ostalo,font, i kako se racuna
    text("Flagovi : " + Flagova_ostalo, width - (85 + (str(Flagova_ostalo)).length() * 10), povrsina_kockice * duzina_tabele_polja + 20); // -||-
    if(Polja_ostalo_levo == 0){
      Pobeda = true;
    }
  }
  else if(Pobeda && !Pobeda_sledeci_Frame){              // pobeda >pobedio si!
    for(int i = 0; i < duzina_tabele_polja; i++){
      for(int j = 0; j < duzina_tabele_polja; j++){
        if(Polje.ne_ukljuceno[i][j] == 1){
          Polja_ostalo_levo--;
          if(Polje.polje_matrica[i][j] == -1){
            image(mina, j * povrsina_kockice, i * povrsina_kockice);
          }
          else{
            image(br.get(Polje.Bomba_oko_mene(i, j)), j * povrsina_kockice, i * povrsina_kockice);
          }
        }
        else if(Polje.ne_ukljuceno[i][j] == 2){
          image(zastava_flag, j * povrsina_kockice, i * povrsina_kockice);
          Polja_ostalo_levo--;
        }
        else{
          image(block, j * povrsina_kockice, i * povrsina_kockice);
        }
      }
    }
    fill(0);
    textSize(15);
    text("Pobedio si!", width / 2 - 40, povrsina_kockice * duzina_tabele_polja + 20);
    Pobeda_sledeci_Frame = true;
  }
  else if(Mrtav){            //  ako si mrtav tj izgubio si !
    if(Mrtav_sledeci_Frame){
      for(int i = 0; i < duzina_tabele_polja; i++){
        for(int j = 0; j < duzina_tabele_polja; j++){
          if(Polje.ne_ukljuceno[i][j] == 1){
            Polja_ostalo_levo--;
            if(Polje.polje_matrica[i][j] == -1){
              image(mina, j * povrsina_kockice, i * povrsina_kockice);
            }
            else{
              image(br.get(Polje.Bomba_oko_mene(i, j)), j * povrsina_kockice, i * povrsina_kockice);
            }
          }
          else if(Polje.ne_ukljuceno[i][j] == 2){
            image(zastava_flag, j * povrsina_kockice, i * povrsina_kockice);
            Polja_ostalo_levo--;
            Flagova_ostalo--;
          }
          else{
            image(block, j * povrsina_kockice, i * povrsina_kockice);
          }
        }
      }
      fill(0);
      textSize(15);
      text("Izgubio si!", width / 2 - 40, povrsina_kockice * duzina_tabele_polja + 20);
    }
    Mrtav_sledeci_Frame = false;
  }
}

public void settings(){
  size(povrsina_kockice * duzina_tabele_polja, povrsina_kockice * duzina_tabele_polja + 30);
}

void mousePressed(){                                  // pozicija misa na tabeli
  int y = mouseY / povrsina_kockice;
  int x = mouseX / povrsina_kockice;
  
  if(mouseButton == LEFT){
    if(Polje.ne_ukljuceno[y][x] != 2){
      if(Polje.polje_matrica[y][x] == -1){
        Mrtav = true;
        for(int i = 0; i < duzina_tabele_polja; i++){
          for(int j = 0; j < duzina_tabele_polja; j++){
            if(Polje.polje_matrica[i][j] == -1){
              Polje.ne_ukljuceno[i][j] = 1;
            }
          }
        }
      }
      otkriveni_blokovi(y, x);
    }
  }
  else if(mouseButton == RIGHT){
    if(Polje.ne_ukljuceno[y][x] != 1){
      if(Polje.ne_ukljuceno[y][x] == 2){
        Polje.ne_ukljuceno[y][x] = 0;
      }
      else{
        Polje.ne_ukljuceno[y][x] = 2;
      }
    }
  }
}

void otkriveni_blokovi(int row, int col){          // sve mogucnosti za blokove 
  if(Polje.Bomba_oko_mene(row, col) == 0){
    if(Polje.ne_ukljuceno[row][col] != 1){
      if(row == 0 && col == 0){
        for(int i = row; i <= row + 1; i++){
          for(int j = col; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == 0 && col == duzina_tabele_polja - 1){
        for(int i = row; i <= row + 1; i++){
          for(int j = col - 1; j <= col; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == duzina_tabele_polja - 1 && col == 0){
        for(int i = row - 1; i <= row; i++){
          for(int j = col; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == duzina_tabele_polja - 1 && col == duzina_tabele_polja - 1){
        for(int i = row - 1; i <= row; i++){
          for(int j = col - 1; j <= col; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == duzina_tabele_polja - 1 && col == duzina_tabele_polja - 1){
        for(int i = row - 1; i <= row; i++){
          for(int j = col - 1; j <= col; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == 0){
        for(int i = row; i <= row + 1; i++){
          for(int j = col - 1; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(col == 0){
        for(int i = row - 1; i <= row + 1; i++){
          for(int j = col; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(row == duzina_tabele_polja - 1){
        for(int i = row - 1; i <= row; i++){
          for(int j = col - 1; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else if(col == duzina_tabele_polja - 1){
        for(int i = row - 1; i <= row + 1; i++){
          for(int j = col - 1; j <= col; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
      else{
        for(int i = row - 1; i <= row + 1; i++){
          for(int j = col - 1; j <= col + 1; j++){
            if(!(i == row && j == col) && Polje.polje_matrica[i][j] != -1){
              Polje.ne_ukljuceno[row][col] = 1;
              otkriveni_blokovi(i, j);
            }
          }
        }
      }
    }
  }
  else{
    Polje.ne_ukljuceno[row][col] = 1;
  }
}

//ovo je naknadno ubaceno na klik r da upali sva dostupna polja preko case-a

void keyReleased(){
  switch(key){
    case 'r': for(int i = 0; i < Polje.polje_matrica.length; i++){
                for(int j = 0; j < Polje.polje_matrica[0].length; j++){
                  if(Polje.polje_matrica[i][j] != -1){                             // kada -1 onda je bomba 
                    Polje.ne_ukljuceno[i][j] = (Polje.ne_ukljuceno[i][j] + 1) % 2;
                  }
                }
              }
  }
}
