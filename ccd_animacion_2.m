clear all
clc

pf=[-5;-5];

gdl=4;

x1=3;
x2=6;
x3=5;
x4=8;
x5=0;
x6=0;
x7=0;
x8=0;

xaux=x1+x2+x3+x4+x5+x6+x7+x8;
xdatos=[x1,x2,x3,x4,x5,x6,x7,x8];

suma=0;

for i=1:gdl+1
    xpos(i)=suma;
    if(i==1)
       suma=suma+xdatos(i);
    end
    if(i>1)
    suma=suma+xdatos(i);
    end
end

for i=1:gdl+1
    ypos(i)=0;
end

for i = 1:gdl
    angulo(i) = 0;
    xesl(i)=xdatos(i);
end

linea=[xpos',ypos'];
angulo=angulo';
paso=0;

error=dist([xpos(gdl+1) ypos(gdl+1)],pf);

while(error>1)
    for i = gdl:-1:1,
        ef=linea(gdl+1,:);
        art=linea(i,:);
        a=(ef-art)/norm(ef-art);
        b=(pf'-art)/norm(pf'-art);
        teta=acosd(dot(a,b));
        dir = cross([a(1) a(2) 0],[b(1) b(2) 0]);
        if dir(3) < 0,
        teta=-teta;
        end
        if teta>15,
            N=100;
        else
            N=30;
        end
        for alfa=teta/N:teta/N:teta,
        R=[cosd(teta/N) -sind(teta/N);sind(teta/N) cosd(teta/N)];
        paso=paso+1;
        for k=gdl+1:-1:i+1,
             ptoR=R*(linea(k,:)-linea(i,:))';
             linea(k,1) = ptoR(1) + linea(i,1);
             linea(k,2) = ptoR(2) + linea(i,2);
        end
        temp(paso,:)=linea(gdl+1,:);
        plot(linea(:,1),linea(:,2),'o-b','LineWidth',2,'MarkerFaceColor','g')
        axis([-suma suma -suma suma])
        grid on
        hold on
        plot([art(1) pf(1)],[art(2) pf(2)],'-.k')
        %plot([j(1) linea(gdl+1,1)],[j(2) linea(gdl+1,2)],'--k')
        plot(pf(1),pf(2),'or','LineWidth',3)
        pause(0.01)
        axis([-suma suma -suma suma])
        hold off
        end
        error = dist(linea(gdl+1,:),pf');
    end
end