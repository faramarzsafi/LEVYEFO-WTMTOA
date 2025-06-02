function [newposition] = New_GT(GTsPosition,LPosition,GlobalPosition,Lambda,Theta,Beta)

Dim=length(GTsPosition);
G=Beta*(GlobalPosition-GTsPosition)+(1-Beta)*(LPosition-GTsPosition)+GTsPosition;
d=(G-GTsPosition);
D=norm(d);
IP=randn(Dim,1)'*(D/10)+G;
%===============================
d2=(IP-GTsPosition);

IP2=d*((d.'*d2)/(norm(d)^2))+GTsPosition;
IP=IP-IP2;
Phi=Theta*rand;
Gamma=Lambda*rand;
IP=(IP/norm(IP))*tan(Phi)*D;
IP=IP+G;
V=(IP-GTsPosition);
newposition=(V/norm(V))*D*Gamma+GTsPosition;

if sum(isnan(newposition))
    newposition=GTsPosition;
end
end


