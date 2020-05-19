clc;
clear;
close all;
    global X mu_X mu_xi  ;
    altsinir_x=-1; ustsinir_x=18; altsinir_y=-1; ustsinir_y=7; altsinir_z=-1; ustsinir_z=12;
   
     xi=1; yi=3; zi=0; 

    %1. Talebin geldiði müþteri sayýsý giriþine ait üyelik fonksiyonlarý ve bulanýklaþtýrma
    
    Ucgen(altsinir_x,-1,3,7,ustsinir_x,xi); x_talepAz=X; mu_talepAz=mu_X; mu_xi_talepAz=mu_xi;
    Ucgen(altsinir_x,2,7,12,ustsinir_x,xi); x_talepOrta=X; mu_talepOrta=mu_X; mu_xi_talepOrta=mu_xi;
    Ucgen(altsinir_x,7,12,18,ustsinir_x,xi); x_talepCok=X; mu_talepCok=mu_X; mu_xi_talepCok=mu_xi;
    
    %2. Yazýlým eforu giriþine ait üyelik fonksiyonlarý ve bulanýklaþtýrma
   
    Ucgen(altsinir_y,-1,1,3,ustsinir_y,yi); y_eforAz=X; mu_eforAz=mu_X; mu_yi_eforAz=mu_xi;
    Ucgen(altsinir_y,1,3,5,ustsinir_y,yi); y_eforOrta=X; mu_eforOrta=mu_X; mu_yi_eforOrta=mu_xi;
    Ucgen(altsinir_y,3,5,7,ustsinir_y,yi); y_eforCok=X; mu_eforCok=mu_X; mu_yi_eforCok=mu_xi;
    
    %3. Yapýlma durumu çýkýþýna ait üyelik fonksiyonlarý
    
    Ucgen(altsinir_z,-1,1,2,ustsinir_z,zi); z_yapilmamali=X; mu_yapilmamali=mu_X; 
    Ucgen(altsinir_z,1,4,7,ustsinir_z,zi); z_kanaat=X; mu_kanaat=mu_X; 
    Ucgen(altsinir_z,6,7,9,ustsinir_z,zi); z_yapilmali=X; mu_yapilmali=mu_X; 
    Ucgen(altsinir_z,8,9,12,ustsinir_z,zi); z_myapilmali=X; mu_myapilmali=mu_X; 

    % ve baðlaçlarý ve min operatörleri kullanýlmýþtýr

    %1.Kural Müþteri sayýsý ve efor az ise 
    mu_kural1=min(mu_xi_talepAz,mu_yi_eforAz);
    %2.Kural Müþteri sayýsý orta, efor az ise 
    mu_kural2=min(mu_xi_talepAz,mu_yi_eforOrta);
    %3.Kural Müþteri sayýsý yüksek, efor az ise
    mu_kural3=min(mu_xi_talepAz,mu_yi_eforCok);
  
    %4.Kural Müþteri sayýsý az, efor orta ise
    mu_kural4=min(mu_xi_talepOrta,mu_yi_eforAz);
    %5.Kural Müþteri sayýsý orta, efor orta ise
    mu_kural5=min(mu_xi_talepOrta,mu_yi_eforOrta);
    %6.Kural Müþteri sayýsý çok, efor orta ise
    mu_kural6=min(mu_xi_talepOrta,mu_yi_eforCok);

    %7.Kural Müþteri sayýsý az, efor çok ise
    mu_kural7=min(mu_xi_talepCok,mu_yi_eforAz);
    %8.Kural Müþteri sayýsý orta, efor çok ise 
    mu_kural8=min(mu_xi_talepCok,mu_yi_eforOrta);
    %9.Kural Müþteri sayýsý çok, efor çok ise 
    mu_kural9=min(mu_xi_talepCok,mu_yi_eforCok);

    %Gerektirme operatörü olarak prod(*) kullanýlmýþtýr

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

    %Birleþtirme iþlemi ve  Çýkýþ Bulanýk kümesinin çizdirilmesi
    %Birleþtirme opertörü olarak max kullanýlmýþtýr
    %A=[mu_sonuc1 mu_sonuc2 mu_sonuc3 mu_sonuc4 mu_sonuc5 mu_sonuc6 mu_sonuc7 mu_sonuc8 mu_sonuc9];
    %mu_birlestirme=max(A);
    mu_birlestirme=max([max(mu_sonuc1,mu_sonuc2);max(mu_sonuc3,mu_sonuc4);max(mu_sonuc5,mu_sonuc6);max(mu_sonuc7,mu_sonuc8);mu_sonuc9]);
    figure
    plot(X,mu_birlestirme);

    %Durulaþtýrma iþlemi ve durulaþtýrma sonucunun grafikte gösterimi
    %Durulaþtýrma operatörü olarak aðýrlýk merkezi kullanýlmýþtýr
    toplam_alan=sum(mu_birlestirme);
    if toplam_alan == 0
        'Agýrlýk Merkezi Yönteminde Toplam Alan Sýfýr';
    end
    
    z=sum(mu_birlestirme.*X)/toplam_alan;
    hold on;
    boy=0:0.01:1;
    line(z*ones(size(boy)),boy)
    

