unit DM_Encripta;

interface

Uses DM_Global_Var, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, ComCtrls;


    procedure key_Prepare;

    function encripta132( sAction  : String;
                          sString  : String) : String;

implementation

procedure Delay(msecs:integer);
var
   Inicio:longint;
begin
     Inicio:=GetTickCount;
     repeat
           Application.ProcessMessages; {permite realizar otras acciones}
     until ((GetTickCount-Inicio) >= Longint(msecs));
end;


procedure key_Prepare;
begin
   Key[9]  := 'op4563RQSlmkj012NOMPihn_-/HIJKdecf+zyEDFGabZgwABXYWvuxt89CVUqT7Lr;s|';
   Key[36] := '6Ok|K+Fv8UoQg-Hx9Wl1_cwEsjNfIaCtT42Pi;dyDYVqR30zbrBXAh/pMm5unSLe7GZJ';
   Key[8]  := 'ABXWYsrqt5678n234RQSTl|;_-LMKNhgzyxwGHIdcbeupovmCDEFVZUaPk190Jijf+/O';
   Key[7]  := 'yDCEFaZbutsrTSURVpon3456POQW012NXMY;_-/JIKLHkjil+zxwvAB9Gfgehd|qmc78';
   Key[68] := 'cAtxqR/o3-1+e|_0sy5ZnYKUhLrGXp6daHgiQbPC;VT79fIM4Ejuz8NFJSBmwDOW2lvk';
   Key[67] := 'IZUO10B-7YeTz+pPW/gKf_vLGmdX9SoRjxVhs6;El|NMHAiwqrJ8F45bk2QuCytaDn3c';
   Key[66] := '|c1df-bHYp5sVXP_RIZO0;NhDrEvM+kmql84gAj3WizBGUFJ/LCK7oa6uTnwSet29yxQ';
   Key[65] := 'G-R0Xp1alEvWw3O9J45u8VT/LYMQ6kez;FoUIt_B+Cxj7qKfsrghyimHbN2Z|PADnSdc';
   Key[64] := 'hEWoN4O8JBgX1LTQHrxqSZeu27GYVj9CADky;fMz60KIs5/_mdUawFlRt|ibn+vPc3p-';
   Key[63] := 'f|9NV7l/DmOLqTKy2Mb64-h+xuUpdFzogsa0EGXQP8R;JCnSkBZj_ie5wHct1Y3IAvrW';
   Key[62] := 'b8uSLOe+6arxG1gXAT/Wd92MJo|VwyQf4E0HBi7lUjtscp;-F_hINRPm3vznDqYk5CKZ';
   Key[61] := 'PkxhEBNIdJ0f9p;5Ta6o+u-X8M/Z_sHwUKLj7gC1z4vcqm|VAYG3itFbyDOren2RWlSQ';
   Key[60] := 'KxfsgGU4W6_JhFwLvqa+|z/P791cYdmIb3rStjQHiMuEoOk0yZ5RneCDlBAX;28p-TNV';
   Key[6]  := 'FGHIJdcebxywvu9AB8CXrqps5647DVWUYSRmlnkj0123QTPZaOzt+|;_-/LMNKhgoifE';
   Key[59] := '1eza8hvJ/uVR4|tUfiFdGM7SoIXsjEP+nkTlwZAgxmO_YDN9pbK65CyLHW0-23QcBrq;';
   Key[58] := 'qm+7PiJCZSfGyV4KEwOhkrQRjdsF-gDWLAt2/XlU9c6NH_ob5punzI0vYe8|3ax;TMB1';
   Key[57] := 'E+cUv_Ht;dKzZjLg/7Gs9iDpY3ThCPbxVmIR0B8o2-F5fJyq1kNSer|nAuWQalwM6O4X';
   Key[56] := '+rKGtnQZVslEfB8/qe_C7j1v4N;oRpLaMW6FAYc5ukDw0HJxTgby|-3iOdX2zPI9SmUh';
   Key[55] := 'DRIXzVMHmjJl|7Q1bU3fak4yw;BPLxSFr6ec+CNpOqi-WnZTvAY2sG9/5dt0guK_hE8o';
   Key[54] := 'R1NJ/t8lI+Y0_soSMhvHjLFwAqmC2;E|yVQZ3drWT97XOeb5zuniDUc4fx-aBgp6PKkG';
   Key[53] := 'lMZ2;FarnhEOkGvq0-XTLsmNCKI5iY71J+DujPy6|z_dtbwU4e/p3VHcxg9AQSRB8foW';
   Key[52] := 'JPhDM;zXKg7SHq-armNFbTIC0fc/4UOB85jeuwsnk_ZoEY3Gi6t|Q1pW29ldyxRv+LAV';
   Key[51] := 'OK/Ypb3|G9RyEA64lzujsNxkdC7-qnfJo_wVrv20tSID8c1HW;MLXBTeUQhPmiZ5aF+g';
   Key[50] := 'BX|+GCs7k0-A6wrDoj2guPMi1b_af/ROIZF9TNzKeHcnd8V43U;QlyWxhtvSLp5mqEJY';
   Key[5]  := '8UTVWSXRrqpo345679PQYOZaNstnmul012ABCMbcLdwvxkjy;|_-/+GHIFJgfheziKED';
   Key[49] := 'YvV62cPiawn1RJSlzCq5mKUot8j|e-Bk3/GxD94OHupfLyEAMF7rWTQdZh;sbIN_gX0+';
   Key[48] := 'Qav9q2+wp4|bA60-KYUkMCLfXT5lteFr_dPIcxomN;si31zWBj8ZG7JSDnRhOHyEuVg/';
   Key[47] := ';JFr3HVOiez6SkfEwA7UPxBWQypu8qjKGv9s4m0La5Y2T-tDol|NMbn1_X/RgCc+dZhI';
   Key[46] := 'kgDuUMfBvTLdWyXI-czY6n0KEASrPJG/w7Hi8Oetq3Q|hapjx2R;b9so4lF_5NCmV+Z1';
   Key[45] := 's3LyBX7k|KcDtdZvmNh_n2iIeFwRATMb+GfWx5Yq4O;/j0HEVSP9gauQp-C6lro8zUJ1';
   Key[44] := '7T3/xAp5yD8m2;ebuFrBUQj|cWRJwGni0g-aSq6_ZEl4NMdtHs91fYzKCIPhvLOXko+V';
   Key[43] := 'TLi-95nFs7U|MHDu80jbCAq1zGZ6W3_yOecEp4Vk/Jar2IgQPhwYRvdXmNoK+BlxStf;';
   Key[42] := 'g/Gbwo40hXAUnNjV6;JvBROl|eW8+ct5-HCQzIZ932Sm_iKdsPFxaDYr1LuEyMkTpq7f';
   Key[41] := '2j;KewCW1Ok_ridGxBs850gLHZ9TofupmPJ/YDt7nhMb+vQ3NIaAy6S|XqUlczFVER-4';
   Key[40] := 'C0Mi-xY6ezFuBW7n|LIcvDr3Rmh+Htp8Q1KbZo5Pf/GaAlSO_JdV;wEgsT2yk49NqUXj';
   Key[4]  := 'vutwsrqp9ABCD8EFGXnmlokjihx45637HIUTVSWYygfzed+c012JKLMNOZabR/-Q_P;|';
   Key[39] := 'nNj;dZwsRo3Mi/Bph+EAV7S4f_aDu95l|Xvq61O-byHtF2cKYxICTPg0zUkWrQ8JemLG';
   Key[38] := '_IyZAq6mOf+FbCWo3Q0M-wYtU2ig/Hc9NJEdv|Br7n4SPxGsl5Vk1;ezLKpD8RXuahjT';
   Key[37] := '9VmM_vWNj;I/cxCTQ1ftAS3Okgbwro0GD8q6nLh|Je+yBXU2K-HuZp5RiPdzYFsEl47a';
   Key[1]  := 'LhgfiejdckbalZmYXnWVoU_-/+zyxwvut;srqpTSRQPO657894ABC3DEF2GHI1JKM0N|';
   Key[35] := 'rSn3j/GxX8T40M_dytBlzFRmgc-HZAqP2NhJeawCVp1LI+DYu765UQOk;Efv9|WoKsbi';
   Key[34] := '/bPlkK_cxCt85mMh;HdzyWX9qQ2i|IwYsp4gaVSAoNj+DuO6LG0e-ErTnJZBF7U3v1Rf';
   Key[33] := 'wCoj0fIu5RNiFaxrSKe-ZyVQl1g_bzAX9UO32k;Gvsn7MPh|EHc+BW8Yq6TLpDmt4/Jd';
   Key[32] := '-HdxDY9VqQMjIfbWt5SJ/eAZn0k;yCU6Rr31NFgwsP|hzEau8XOo2_i+Tpm4KcBvLGl7';
   Key[31] := 'Mi_HIW5To2P;KgcwYst3O/dB9V60QlJhxu1GfzEvCZqUn|-LeyS78mRj+aDpXkb4ArNF';
   Key[30] := 'eFwAr6T2PL/cxDY8pok0NJGHZ5V3;QyEdBb7Rl-MhIg9Cf4a|W+zSnvOtsKiumqUXj_1';
   Key[3]  := 'u9ABC8DEFGHI7bacZdYeXfWghwvtsrxqpoynm23456JK1LMNUViTjSklRzQ+_-;/P|O0';
   Key[29] := 'tQl_HIdyCZ9qpRiJ+EDaw8srTnPj12KLFcX5o3|Ngf-GbzWvSm4Ok0hBeAYVU6u7;Mx/';
   Key[28] := 'S2Ok|JKg+bwBCYs7UVp4Qml0MHfezDacv9WtPRn;_FyAXNqIji-Exu6Zr538To1hGdL/';
   Key[27] := 'W78poj|Kf/aVXtNmn2LiHbyxSP3kh0I_ZzBCUu9RQr5J;Fe+DcvsOl4Mg16T-EdYwAGq';
   Key[26] := 'j;JzyEuABWS3PQk|Lf+Gcv9YrUONn_-Hea7p5Tm2Mi01KhxFdCDbtXq68o4I/wglRZVs';
   Key[25] := 'xtsT4Lh_zyX9UonOPk12K|EFvBYSl56Qi0Mf-/HarACpmgR;cwujqd7Jb3INZWVG+8De';
   Key[24] := 'Nl0Lhg-GHcCZYUVs56Rp23Pn;iFBv84TSq|Mk+JfEDdeaWu1Qtr_mzxwKj7Oob/AXIy9';
   Key[23] := 'mn21Okgf-HDvu9qji34Ned;JKa+zEBVS5Ql|LyGZwtAWU78XRTp0PMohcbr/xs6CY_FI';
   Key[22] := '56SnmNi;_IdezEFZavV7Rpo2O|JKgh+DCwuAX8q31TU04Qlk-MyHLcftBGbxs9PrjWY/';
   Key[21] := 'awBC7ToPQ|;KLh+zcuArq68V3k01Oig-/bZvWspDSRml592MJfe4ENIUjyxGdtnFHY_X';
   Key[20] := 'UqpPl1Lhg_GHdczCDZ89Wtu56SoOk|;MKi/+FbaxABXYvRrn2NQmIf-y74s3EVjwJTe0';
   Key[2]  := 'cdbeayxzwvutsrABCD9EFGH8IJKL7MNZfYgXhWiVjUkTlSmRnQoPpO_-/;+q654|3210';
   Key[19] := 'i_-cbDEYUrqPQ23Mk|;Ig+zGavuABWXs7nNOKhFedx98Z6TptRmlH/yCVSwo4jf01J5L';
   Key[18] := 'zyEFZut9AVWpo5lNOP|;JIfe+DCbcvs46Tmk1QRiKLhg-/Yw78XUrq23SMnjHGxd0Ba_';
   Key[17] := '45QRSm01NMj-/IJfegyxDEabutAqp78nlhiKH_+XYvBCVUsr63TWokw2dc|;POzZF9LG';
   Key[16] := 'ZYavu9AUTn12JK/+FGHwtXbqpRlmNO|;E-zDdex8BorQi45hg03fcjLVW_y7CPMSskI6';
   Key[15] := '345QR|;LMNih+zIedxwDEatABpqUTm12kj_-bcvuFXWVrs9POnlgJHKfoYSZ78GyC60/';
   Key[14] := 'dzYmnl2MLihg;_GHIbcyxBCDWX89SRr3POpo|JK/+wEFut67Zasq451ANVekjvTfU-Q0';
   Key[13] := 'Xs78TUS34PQnml|;_JKLhg+zFEedabZVWR5NOr1I-GokyBCiw9fc62juv0MYtADpx/qH';
   Key[12] := 'poq45Qkj012NOPhig_-/IHJcyxDEFZYvutn897UTml3RSVferKLGdsb;|+BCAXaWzw6M';
   Key[11] := 'Hfeg+zyDEFZYavutsSTRp567mln234ijh|;_JKLbXW/xwrBCGokd98APQOqcVU01INM-';
   Key[10] := 'VWrqQPmn2345NORkjli|;_cdbzyxUXTABCSYMtusp7869KLohv1D0JZIawEFGf+-/gHe';

end;


function Encripta132( sAction  : String;
                      sString  : String) : String;
var
  //inicio : Integer;
  sKey   : String;
  iKey1  : Integer;
  iKey2  : Integer;
  i      : iNTEGER;
begin
  Result := '';
  sKey := '';
  key_Prepare;

  if sAction = 'E' then
  begin
    // Se necesita un Delay entre cada Randomize
    Delay(1);
    Randomize;
    iKey1 := random(67)+1;
    sKey := FormatFloat('000',iKey1);
    for i := 1 to 3 do
        Result:= Result + Copy(key[33],Pos(sKey[i],key[60]),1);

    //Randomize;
    iKey2 := random(67)+1;
    while iKey1 = iKey2 do
          iKey2 := random(67)+1;

    sKey := FormatFloat('000',iKey2);
    for i := 1 to 3 do
        Result:= Result + Copy(key[33],Pos(sKey[i],key[60]),1);




    for i := 1 to length(sString) do
        Result:= Result + Copy(key[iKey1],Pos(sString[i],key[iKey2]),1);

  end
  else
  begin
    for i := 1 to 3 do
        sKey := sKey + Copy(key[60],Pos(sString[i],key[33]),1);
        try
          iKey1 := StrToInt(sKey)
        except
           Result := '';
           exit;
        end;
    sKey := '';
    for i := 4 to 6 do
        sKey := sKey + Copy(key[60],Pos(sString[i],key[33]),1);
        try
          iKey2 := StrToInt(sKey)
        except
           Result := '';
           exit;
        end;



   for i := 7 to length(sString) do
       Result:= Result + Copy(key[iKey2],Pos(sString[i],key[iKey1]),1);

  end;


end;


end.
