clc;
clear;
close all;
    global X mu_X mu_xi  ;
    altsinir_x=-1; ustsinir_x=18; altsinir_y=-1; ustsinir_y=7; altsinir_z=-1; ustsinir_z=12;
   
     xi=1; yi=3; zi=0; 

    %1. Talebin geldi�i m��teri say�s� giri�ine ait �yelik fonksiyonlar� ve bulan�kla�t�rma
    
    Ucgen(altsinir_x,-1,3,7,ustsinir_x,xi); x_talepAz=X; mu_talepAz=mu_X; mu_xi_talepAz=mu_xi;
    Ucgen(altsinir_x,2,7,12,ustsinir_x,xi); x_talepOrta=X; mu_talepOrta=mu_X; mu_xi_talepOrta=mu_xi;
    Ucgen(altsinir_x,7,12,18,ustsinir_x,xi); x_talepCok=X; mu_talepCok=mu_X; mu_xi_talepCok=mu_xi;
    
    %2. Yaz�l�m eforu giri�ine ait �yelik fonksiyonlar� ve bulan�kla�t�rma
   
    Ucgen(altsinir_y,-1,1,3,ustsinir_y,yi); y_eforAz=X; mu_eforAz=mu_X; mu_yi_eforAz=mu_xi;
    Ucgen(altsinir_y,1,3,5,ustsinir_y,yi); y_eforOrta=X; mu_eforOrta=mu_X; mu_yi_eforOrta=mu_xi;
    Ucgen(altsinir_y,3,5,7,ustsinir_y,yi); y_eforCok=X; mu_eforCok=mu_X; mu_yi_eforCok=mu_xi;
    
    %3. Yap�lma durumu ��k���na ait �yelik fonksiyonlar�
    
    Ucgen(altsinir_z,-1,1,2,ustsinir_z,zi); z_yapilmamali=X; mu_yapilmamali=mu_X; 
    Ucgen(altsinir_z,1,4,7,ustsinir_z,zi); z_kanaat=X; mu_kanaat=mu_X; 
    Ucgen(altsinir_z,6,7,9,ustsinir_z,zi); z_yapilmali=X; mu_yapilmali=mu_X; 
    Ucgen(altsinir_z,8,9,12,ustsinir_z,zi); z_myapilmali=X; mu_myapilmali=mu_X; 

    % ve ba�la�lar� ve min operat�rleri kullan�lm��t�r

    %1.Kural M��teri say�s� ve efor az ise 
    mu_kural1=min(mu_xi_talepAz,mu_yi_eforAz);
    %2.Kural M��teri say�s� orta, efor az ise 
    mu_kural2=min(mu_xi_talepAz,mu_yi_eforOrta);
    %3.Kural M��teri say�s� y�ksek, efor az ise
    mu_kural3=min(mu_xi_talepAz,mu_yi_eforCok);
  
    %4.Kural M��teri say�s� az, efor orta ise
    mu_kural4=min(mu_xi_talepOrta,mu_yi_eforAz);
    %5.Kural M��teri say�s� orta, efor orta ise
    mu_kural5=min(mu_xi_talepOrta,mu_yi_eforOrta);
    %6.Kural M��teri say�s� �ok, efor orta ise
    mu_kural6=min(mu_xi_talepOrta,mu_yi_eforCok);

    %7.Kural M��teri say�s� az, efor �ok ise
    mu_kural7=min(mu_xi_talepCok,mu_yi_eforAz);
    %8.Kural M��teri say�s� orta, efor �ok ise 
    mu_kural8=min(mu_xi_talepCok,mu_yi_eforOrta);
    %9.Kural M��teri say�s� �ok, efor �ok ise 
    mu_kural9=min(mu_xi_talepCok,mu_yi_eforCok);

    %Gerektirme operat�r� olarak prod(*) kullan�lm��t�r

    %1.Kural
    mu_sonuc1=mu_kural1*mu_kanaat;
    %2.Kural
    mu_sonuc2=mu_kural2*mu_yapilmamali;
    %3.Kural
    mu_sonuc3=mu_kural3*mu_yapilmamali;
    %4.Kural
    mu_sonuc4=mu_kural4*mu_yapilmali;
    %5.Kural
    mu_sonuc5=mu_kural5*mu_kanaat;
    %6.Kural
    mu_sonuc6=mu_kural6*mu_kanaat;
    %7.Kural
    mu_sonuc7=mu_kural7*mu_myapilmali;
    %8.Kural
    mu_sonuc8=mu_kural8*mu_yapilmali;
    %9.Kural
    mu_sonuc9=mu_kural9*mu_kanaat;

    %Birle�tirme i�lemi ve  ��k�� Bulan�k k�mesinin �izdirilmesi
    %Birle�tirme opert�r� olarak max kullan�lm��t�r
    %A=[mu_sonuc1 mu_sonuc2 mu_sonuc3 mu_sonuc4 mu_sonuc5 mu_sonuc6 mu_sonuc7 mu_sonuc8 mu_sonuc9];
    %mu_birlestirme=max(A);
    mu_birlestirme=max([max(mu_sonuc1,mu_sonuc2);max(mu_sonuc3,mu_sonuc4);max(mu_sonuc5,mu_sonuc6);max(mu_sonuc7,mu_sonuc8);mu_sonuc9]);
    figure
    plot(X,mu_birlestirme);

    %Durula�t�rma i�lemi ve durula�t�rma sonucunun grafikte g�sterimi
    %Durula�t�rma operat�r� olarak a��rl�k merkezi kullan�lm��t�r
    toplam_alan=sum(mu_birlestirme);
    if toplam_alan == 0
        'Ag�rl�k Merkezi Y�nteminde Toplam Alan S�f�r';
    end
    
    z=sum(mu_birlestirme.*X)/toplam_alan;
    hold on;
    boy=0:0.01:1;
    line(z*ones(size(boy)),boy)
    

