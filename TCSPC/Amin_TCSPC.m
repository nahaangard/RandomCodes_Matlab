Method='exp2';
Size_ch=0.11; % ns

close all;
colordef('black');
ch=A(:,1);Prompt=A(:,2);Decay=A(:,3);
TAC_size=length(A);
[~,x1]=max(Decay);
y1=length(Prompt)-400;
subplot(3,1,1);
plot(ch,Decay,ch,Prompt);
ylabel('Counts');xlabel('channels');
legend('Decay','Prompt');
subplot(3,1,2);
plot((ch.*Size_ch),Decay,(ch.*Size_ch),Prompt);
ylabel('Counts');xlabel('Time (ns)');
legend('Decay','Prompt');
f=fit((ch(x1:y1)),Decay(x1:y1),Method);
subplot(3,1,3);
D=coeffvalues(f);
DD=coeffnames(f);
formulaT=D(1,1).*exp(D(1,2).*(x1:y1));
plot(ch(x1:y1),Decay(x1:y1),'.-r',ch,Prompt,'.-g',...
    ch(x1:y1),formulaT','-.b');
switch (Method)
    case 'exp1'
L1=-1/D(1,2)*Size_ch;
if L1>100
    fprintf('LifeTime is %g (us)\n',L1/1000);
    else
    fprintf('LifeTime is %g (ns)\n',L1);
end
    case 'exp2'
        L1=-1/D(1,2)*Size_ch;
        L2=-1/D(1,4)*Size_ch;
        fprintf('LifeTime is %g and %g (ns)\n',L1,L2);
end
ylabel('Counts');xlabel('Time (ns)');
legend('Decay','Prompt','Fit');