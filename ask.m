clear all
clc

b = '100101010' %binary data
fs = 100; %sampling frequency
t = 0:1/fs:1-1/fs ; %time interval
len = length(b);
p0 = zeros(1,length(t));
p1 = ones(1,length(t));

%binary graph
y=[];
for n=1:len
    if b(n)=='0'
        x=p0;
    else
        x=p1;
    end
    y = [y x];
end
subplot(411)
stairs(y);
title('binary data');
axis([0 1000, -1 1.5]);

sm = cos(2*pi*10*t); %carrier signal

cr=[]
for n=1:len
    cr=[cr sm];
end
subplot(412)
plot(cr)
title('carrier signal')  

s = y.*cr;
subplot(413)
plot(s)
title('ASK modulated')
axis([0 1000, -1.5 1.5]);
%demodulation

a = length(t);
demod=[]
for i=a:a:length(s)
    c = cos(2*pi*10*t);
    d = c.*s((i-(a-1)):i);

     z = trapz(t,d);
     rz = round(2*z*fs);
     
  if(rz > 1)             % Logical condition 
    w = 1;
  else
    w = 0;
  end
  demod = [demod w];
end
subplot(414)
stairs(demod);
title('demodulated signal')
axis([1 8, -1 1.5]);