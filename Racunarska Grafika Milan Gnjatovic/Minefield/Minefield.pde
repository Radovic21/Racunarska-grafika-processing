class Minsko_polje{
  int polje_matrica[][] = new int [duzina_tabele_polja][duzina_tabele_polja];        
  int ne_ukljuceno[][] = new int [duzina_tabele_polja][duzina_tabele_polja];         
  int Bomba_oko_Mene;
  
  Minsko_polje(){
    for(int i = 0; i < duzina_tabele_polja * 4; i++){
      int col = floor(random(duzina_tabele_polja));
      int row = floor(random(duzina_tabele_polja));
      while(polje_matrica[row][col] == -1){
        col = floor(random(duzina_tabele_polja));
        row = floor(random(duzina_tabele_polja));
      }
      polje_matrica[row][col] = -1;
    }
  }
  
  int Bomba_oko_mene(int row, int col){
    Bomba_oko_Mene = 0;
    try{
      if(polje_matrica[row - 1][col - 1] == -1){             
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row - 1][col] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row - 1][col + 1] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row][col - 1] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row][col + 1] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row + 1][col - 1] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row + 1][col] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    try{
      if(polje_matrica[row + 1][col + 1] == -1){
        Bomba_oko_Mene++;
      }
    }
    catch(Exception e){
    }
    return Bomba_oko_Mene;
  }
}
