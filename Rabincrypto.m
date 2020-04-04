%-- Rounak Nayee --- 1613091--
%-- K.J.Somaiya College of Engineering
%-- Rabin Cryptosystem

clc;
clear all;
close all;
% -- P and Q can be Prime Numbers with 4k+3
% -- P ≡ Q ≡ 3(mod 4)
p = input('Enter the value of p: ');
q = input('Enter the value of q: ');
n = p*q;
public_key = n;

plain = input('Enter PlainText');

%Plain To Cipher Text
cipher = mod(plain^2,public_key);
disp('The value of CipherText is');
disp(cipher);

%Cipher To Plain Text using CRT(4 Values)
[P(1),P(2),P(3),P(4)] = rabindecrpyt(cipher,p,q);
disp('Four Possible Plain Text');
disp(P);

function [p1,p2,p3,p4] = rabindecrpyt(c,p,q)
    a1 = exponentmod(0,c,(p+1)/4,p);
    a2 = exponentmod(1,c,(p+1)/4,p);
    b1 = exponentmod(0,c,(q+1)/4,q);
    b2 = exponentmod(1,c,(q+1)/4,q);
    % CRT called 4 Times
    p1 = crtfunction(2,[a1 b1],[p q]);
    p2 = crtfunction(2,[a1 b2],[p q]);
    p3 = crtfunction(2,[a2 b1],[p q]);
    p4 = crtfunction(2,[a2 b2],[p q]);
end

function a=exponentmod(f,b,e,m)
if m==1
    a=0;
    return
end
i=1;
a=1;
while i<=e
    a = mod(sym(a*b),m);
    disp(i);
    i = i+1;
end
if f==0
end
if f==1
    a = mod(-(a),m);
end
end

function c = crtfunction(n,a,m)
j=1;
M=1;
while j<=n
    M=M*m(j);
    j=j+1;
end
%disp('Value of M')
%disp(M)
k=1;
while k<=n
    M_a(k)=(M/m(k));
    k=k+1;
end
%disp('Values of M_a')
%disp(M_a)
p=1;
while p<=n
    x=m(p);
    y=M_a(p);
    g=gcd(x,y);
    if g==1
        r1=x;
        r2=y;
        r=mod(r1,r2);
        t1=0;
        t2=1;
        while r~=0
            r=mod(r1,r2);
            q=floor(r1/r2);
            r1=r2;
            r2=r;
            t=t1-(t2*q);
            t1=t2;
            t2=t;
        end

        if t1<0
            t1=t1+m(p);
        end
        M_inverse(p)=t1;
        p=p+1;
    else
        disp('Invalid values for multiplicative inverse')
        return
    end 
end
%disp('Values of M_inverse')
%disp(M_inverse)
q=1;
z=0;
while q<=n
    z=(a(q)*M_a(q)*M_inverse(q))+z;
    q=q+1;
end
c=mod(z,M);
end
