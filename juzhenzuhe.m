format long
a=[Hperiod DDperiodt UDperiodt Ht DDti UDti Hi DDie UDie He DDefive UDefive Hfive DDfiveShiftr UDfiveShiftr HShiftr DDShiftro UDShiftro Ho DDoa UDoa Ha DDan UDan Hn DDnl UDnl Hl DDlReturn UDlReturn HReturn ];
for i=1:1:51
    for j=1:1:400
        for k=1:1:31
            b(:,k,i)=a((i-1)*j+1:i*j,k);
        end
    end
end
temp=0;
for i=1:1:51
    for j=1:31
        for k=1:200
            temp=temp+sum(b(k,j,i));
        end
        means(i,j)=temp/200;
        temp=0;
    end
end
%**************方法1************%******%******%******%******%******%******%******%******%******%******%******%******%******%******%******%**%******%******%**%******%******%**%******%******%
for i=1:1:51
    for j=1:1:51
        for k=1:1:5
            if i==j
                for m=1:1:200
                    userscore(i,m)=norm((b(m+200,:,i)-means(i,:)))^2;
                end
            else 
                imposterscore(j,k,i)=norm((b(k,:,j)-means(j,:)))^2;
            end
        end
    end
end
onehit=[];
%yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% imposterscore=imposterscore(:,:,19);
% userscore=userscore(19,:);

nn=zeros(50,5);np=zeros(50,5);
pn=zeros(1,200);pp=zeros(1,200);
jieguo=zeros(51,1);
for yuzhi=0:0.01:7
    for i=1:51
        iposterscore=imposterscore(:,:,i);
        iposterscore(i,:)=[];
        for k=1:50
            for j=1:5
                for m=1:200
                    if(userscore(i,m)>yuzhi)
                        pn(1,m)=1;
                    else pp(1,m)=1;
                    end
                end
                if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
                    nn(k,j)=1;
                else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
                        np(k,j)=1;
                    end
                end
            end
        end
        hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
        falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
%         plot(hitrate,falserate,'.-')
%         axis([0 1 0 1])
%         hold on
        if (1-hitrate-falserate==0)
            jieguo(i,1)=falserate;
        end
          if((1-hitrate)==0)
              onehit=[onehit,falserate];
          end
        nn=zeros(50,5);np=zeros(50,5);
        pn=zeros(1,200);pp=zeros(1,200);
    end
end
equal=mean(jieguo(:))
zeromiss=min(onehit(:))



% % %**************方法2************%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%**%******%******%**%******%******%
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     userscore(i,m)=norm(((b(m+200,:,i)-means(i,:))).^2)/(norm((means(i,:)))*norm(b(m+200,:,i)));
%                 end
%             else
%                imposterscore(j,k,i)=norm(((b(k,:,j)-means(j,:))).^2)/(norm((means(j,:)))*norm(b(k,:,j)));
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=0:0.01:5
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
% % %**************方法2************%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%*********%**%******%******%**%******%******%


%**************方法3************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     userscore(i,m)=sum((b(m+200,:,i)-means(i,:)));
%                 end
%             else 
%                 imposterscore(j,k,i)=sum((b(k,:,j)-means(j,:)));   
%             end
%         end
%     end
% end
% 
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-6:0.01:7
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法3************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%





%**************方法4************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% sbias=zeros(51,31);
% for i=1:51
%     for j=1:31
%         for k=1:200
%             sbias(i,j)=sbias(i,j)+(b(k,j,i)-means(i,j)).^2;
%         end
%     end
% end
% for i=1:51
%     for j=1:31
%         sbias(i,j)=sqrt(sbias(i,j)/200);
%     end
% end
% rmeans=zeros(51,31);
% c=zeros(200,31,51);
% for i=1:51
%     for j=1:31
%         for k=1:200
%         if(means(i,j)-b(k,j,i))<(3*sbias(i,j))
%             c(k,j,i)=b(k,j,i);
%         end
%         end
%     end
% end
% for i=1:51
%     for j=1:31
%     rmeans(i,j)=sum(c(:,j,i))/nnz(c(:,j,i));
%     end
% end
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     userscore(i,m)=sum((b(m+200,:,i)-rmeans(i,:)));
%                 end
%             else 
%                 imposterscore(j,k,i)=sum((b(k,:,j)-rmeans(j,:)));   
%             end
%         end
%     end
% end
% 
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% 
% for yuzhi=-20:0.001:7
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0.01)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法4************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%


%**************方法5************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% mabias=zeros(51,31);
% for i=1:51
%     for j=1:31
%         for k=1:200
%             mabias(i,j)=mabias(i,j)+(abs((b(k,j,i)-means(i,j))));
%         end
%     end
% end
% for i=1:51
%     for j=1:31
%         mabias(i,j)=(mabias(i,j)/200);
%     end
% end
% userscore=zeros(51,200);
% imposterscore=zeros(51,5,51);
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     for n=1:31
%                     userscore(i,m)=userscore(i,m)+((sum((b(m+200,n,i)-means(i,n))))/mabias(i,n));
%                     end
%                 end
%             else 
%                 for n=1:31
%                 imposterscore(j,k,i)=imposterscore(j,k,i)+((sum((b(m+200,n,i)-means(i,n))))/mabias(i,n));
%                 end
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% 
% for yuzhi=-20:0.001:7
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0.01)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法5************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法6************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% 
% for i=1:51
%     for m=1:200
%         C(:,:,m,i)=cov(means(i,:),b(m,:,i));
%     end
% end
% c=b(1:200,:,:);
% for i=1:51
% C(:,:,i)=cov(c(:,:,i));
% end
% % C=cov(means)
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     userscore(i,m)=(means(i,:)-b(m+200,:,i))*pinv(C(:,:,i))*((b(m+200,:,i)-means(i,:)))';
%                 end
%             else 
%                 imposterscore(j,k,i)=(means(j,:)-b(k,:,j))*pinv(C(:,:,i))*((b(k,:,j)-means(k,:)))';
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-200:0.1:1
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.1)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法6************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法7************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:200,:,:);
% for i=1:51
%     C(:,:,i)=cov(c(:,:,i));
% end
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     userscore(i,m)=((means(i,:)-b(m+200,:,i))*pinv(C(:,:,i))*((b(m+200,:,i)-means(i,:)))')/(norm((means(i,:)))*norm(b(m+200,:,i)));
%                 end
%             else
%                 imposterscore(j,k,i)=(means(j,:)-b(k,:,j))*pinv(C(:,:,i))*((b(k,:,j)-means(k,:)))'/(norm((means(j,:)))*norm(b(k,:,j)));
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-40:0.1:1
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))


%**************方法7************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法8************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:200,:,:);
% for i=1:51
%     C(:,:,i)=cov(c(:,:,i));
% end
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     for n=1:200
%                         user(m,n,i)=(b(n,:,i)-b(m+200,:,i))*pinv(C(:,:,i))*((b(m+200,:,i)-means(i,:)))';
%                     end
%                 end
%             else
%                 for m=1:200
%                     imposter(j,m,k,i)=(b(m,:,i)-b(k,:,j))*pinv(C(:,:,i))*((b(k,:,j)-means(k,:)))';
%                 end
%             end
%         end
%     end
% end
% for i=1:51
%     for n=1:200
%         userscore(i,n)=max(user(:,n,i));
%     end
% end
% for i=1:51
%     for j=1:51
%         for k=1:5
%             for m=1:200
%                 imposterscore(j,k,i)=imposter(j,:,k,i);
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-40:0.1:1
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))        
%**************方法8************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法9************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:200,:,:);
% for i=1:51
%     %     for m=1:200
%     %     [input,minI,maxI] = premnmx(c(:,:,i)')
%     [inputn,inputps]=mapminmax(c(:,:,i)');
%     output=ones(200,1);
% %     for k=1:200
% %         output(k,1)=1;
% %     end
%     %     output(1,1)=1;
% %     net.layers{1}.initFcn = 'initwb';
%     
%     net = newff( inputn,output',10);
%     [m1,n1]=size(net.IW{1,1});
%     net.IW{1,1}=0.1*ones(m1,n1);
%     [m2,n2]=size(net.LW{2,1});
%     net.LW{2,1}=0.1*ones(m2,n2);
%     net.trainparam.epochs = 500 ;
%     net.trainparam.goal = 0.01 ;
%     net.trainParam.lr = 0.0001 ;
%     net.biases{1,1}.initFcn = 'rands';
%     net.biases{2,1}.initFcn = 'rands';
%     net = init(net);
%     onehit=[];
%     hit=[];
%     %开始训练
%     net = train( net, inputn , output' ) ;
%     for j=1:51
%         if i==j
%                 inputn_test=mapminmax('apply',b(201:400,:,1)',inputps);
%                 BPoutput=sim(net,inputn_test);
%             for m=1:200
%                 userscore(i,m)=BPoutput(:,m);
%             end
%         else 
%              inputn_test=mapminmax('apply',b(1:5,:,j)',inputps);
%                 BPoutput=sim(net,inputn_test);
%                 for k=1:5
%                     imposterscore(j,k,i)=BPoutput(:,k);
%                 end
%         end
%     end
% end
            
    
    

    
    
    
%     for yuzhi=0:0.1:1
%         for j=1:51
%             if i==j
%                 output_test=ones(200,31);
%                 inputn_test=mapminmax('apply',b(200:400,:,j)',inputps);
%                 BPoutput=sim(net,inputn_test);
%                 % 结果分析
%                 % 根据网络输出找出数据属于哪类
%                 BPoutput(find(BPoutput<yuzhi))=0;
%                 BPoutput(find(BPoutput>=yizhi))=1;
%                 rightnumber=0;
%                 for i=1:size(output_test,2)
%                     if BPoutput(i)==output_test(i)
%                         rightnumber=rightnumber+1;
%                     end
%                 end
%                 falserate=rightnumber/size(output_test,2)*100;
%                 onehit=[onehit,falserate];
%             else
%                 output_test=ones(5,1);
% %                 for q=1:5
% %                     output_test(q,2)=1
% %                 end
%                 inputn_test=mapminmax('apply',b(1:5,:,j)',inputps);
%                 BPoutput=sim(net,inputn_test);
%                 % 结果分析
%                 % 根据网络输出找出数据属于哪类
%                 BPoutput(find(BPoutput<yuzhi))=0;
%                 BPoutput(find(BPoutput>=yuzhi))=1;
%                 rightnumber=0;
%                 for i=1:size(output_test,2)
%                     if BPoutput(i)==output_test(i)
%                         rightnumber=rightnumber+1;
%                     end
%                 end
%                 hitrate=rightnumber/size(output_test,2)*100;
%                 hit=[hit,falserate];
%             end
%         end
%     end
% end

% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-1:0.1:5
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))

%**************方法9************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法10************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:200,:,:);
% for i=1:51
%     %     for m=1:200
%     %     [input,minI,maxI] = premnmx(c(:,:,i)')
%     [inputn,inputps]=mapminmax(c(:,:,i)');
%     output=ones(200,31);
%     %     for k=1:200
%     %         output(k,1)=1;
%     %     end
%     %     output(1,1)=1;
%     %     net.layers{1}.initFcn = 'initwb';
%     
%     net = newff( inputn,output',31);
%     [m1,n1]=size(net.IW{1,1});
%     net.IW{1,1}=0.1*ones(m1,n1);
%     [m2,n2]=size(net.LW{2,1});
%     net.LW{2,1}=0.1*ones(m2,n2);
%     net.trainparam.epochs = 500 ;
%     net.trainparam.goal = 0.01 ;
%     net.trainParam.lr = 0.0001 ;
%     net.trainParam.mc = 0.0003 ;
%     net.biases{1,1}.initFcn = 'rands';
%     net.biases{2,1}.initFcn = 'rands';
%     net = init(net);
%     onehit=[];
%     hit=[];
%     %开始训练
%     net = train( net, inputn , output' ) ;
%     for j=1:51
%         if i==j
%             for m=1:200
%                 inputn_test=mapminmax('apply',b(200+m,:,i)',inputps);
%                 BPoutput=sim(net,inputn_test);
%                 userscore(i,m)=norm(BPoutput(:,:)'-b(200+m,:,i));
%             end
%         else
%             for k=1:5
%                 inputn_test=mapminmax('apply',b(k,:,j)',inputps);
%                 BPoutput=sim(net,inputn_test);
%                 imposterscore(j,k,i)=norm(BPoutput(:,:)'-b(k,:,j));
%             end
%         end
%     end
% end
% 
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=-1:0.1:5
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法10************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法11************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
%for [lowval,midval,highval]=[(21,25.5,29),(26,29,32),(30,33.5,37),(36,40,44),(42.46.50)]
% for i=1:51
%     for j=1:31
%          for m=1:200
%             if  b(m,j,i)<16 || b(m,j,i)>24
%                 vveryfast(m,j,i)=0;
%             else if  b(m,j,i)<20
%                     vveryfast(m,j,i)= (b(m,j,i)-16)/4;
%                 else if b(m,j,i)==20
%                         vveryfast(m,j,i)=1;
%                     else
%                         vveryfast(m,j,i)=(24-b(m,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m,j,i)<21 || b(m,j,i)>29
%                 veryfast(m,j,i)=0;
%             else if  b(m,j,i)<25.5
%                     veryfast(m,j,i)= (b(m,j,i)-21)/4.5;
%                 else if b(m,j,i)==25.5
%                         veryfast(m,j,i)=1;
%                     else
%                         veryfast(m,j,i)=(29-b(m,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m,j,i)<26 || b(m,j,i)>32
%                 fast(m,j,i)=0;
%             else if  b(m,j,i)<29
%                     fast(m,j,i)= (b(m,j,i)-26)/3;
%                 else if b(m,j,i)==29
%                         fast(m,j,i)=1;
%                     else
%                         fast(m,j,i)=(32-b(m,j,i))/3;
%                     end
%                 end
%             end
%             if  b(m,j,i)<30 || b(m,j,i)>37
%                 moderate(m,j,i)=0;
%             else if  b(m,j,i)<33.5
%                     moderare(m,j,i)= (b(m,j,i)-30)/3.5;
%                 else if b(m,j,i)==33.5
%                         moderate(m,j,i)=1;
%                     else
%                         moderate(m,j,i)=(37-b(m,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m,j,i)<36 || b(m,j,i)>44
%                 slow(m,j,i)=0;
%             else if  b(m,j,i)<40
%                     slow(m,j,i)= (b(m,j,i)-36)/4;
%                 else if b(m,j,i)==40
%                         slow(m,j,i)=1;
%                     else
%                         slow(m,j,i)=(44-b(m,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m,j,i)<42 || b(m,j,i)>50
%                 veryslow(m,j,i)=0;
%             else if  b(m,j,i)<46
%                     veryslow(m,j,i)= (b(m,j,i)-42)/4;
%                 else if b(m,j,i)==46
%                         veryslow(m,j,i)=1;
%                     else
%                         veryslow(m,j,i)=(50-b(m,j,i))/4;
%                     end
%                 end
%             end
%         end
%     end
% end
% for i=1:51
%     for j=1:31
%         for m=1:200
%             if  b(m+200,j,i)<16 || b(m+200,j,i)>24
%                 vveryfastu(m,j,i)=0;
%             else if  b(m+200,j,i)<20
%                     vveryfastu(m,j,i)= (b(m+200,j,i)-16)/4;
%                 else if b(m+200,j,i)==20
%                         vveryfastu(m,j,i)=1;
%                     else
%                         vveryfastu(m,j,i)=(24-b(m+200,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m+200,j,i)<21 || b(m+200,j,i)>29
%                 veryfastu(m,j,i)=0;
%             else if  b(m+200,j,i)<25.5
%                     veryfastu(m,j,i)= (b(m+200,j,i)-21)/4.5;
%                 else if b(m+200,j,i)==25.5
%                         veryfastu(m,j,i)=1;
%                     else
%                         veryfastu(m,j,i)=(29-b(m+200,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m+200,j,i)<26 || b(m+200,j,i)>32
%                 fastu(m,j,i)=0;
%             else if  b(m+200,j,i)<29
%                     fastu(m,j,i)= (b(m+200,j,i)-26)/3;
%                 else if b(m+200,j,i)==29
%                         fastu(m,j,i)=1;
%                     else
%                         fastu(m,j,i)=(32-b(m+200,j,i))/3;
%                     end
%                 end
%             end
%             if  b(m+200,j,i)<30 || b(m+200,j,i)>37
%                 moderateu(m,j,i)=0;
%             else if  b(m+200,j,i)<33.5
%                     moderare(m,j,i)= (b(m+200,j,i)-30)/3.5;
%                 else if b(m+200,j,i)==33.5
%                         moderateu(m,j,i)=1;
%                     else
%                         moderateu(m,j,i)=(37-b(m+200,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m+200,j,i)<36 || b(m+200,j,i)>44
%                 slowu(m,j,i)=0;
%             else if  b(m+200,j,i)<40
%                     slowu(m,j,i)= (b(m+200,j,i)-36)/4;
%                 else if b(m+200,j,i)==40
%                         slowu(m,j,i)=1;
%                     else
%                         slowu(m,j,i)=(44-b(m+200,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m+200,j,i)<42 || b(m+200,j,i)>50
%                 veryslowu(m,j,i)=0;
%             else if  b(m+200,j,i)<46
%                     veryslowu(m,j,i)= (b(m+200,j,i)-42)/4;
%                 else if b(m+200,j,i)==46
%                         veryslowu(m,j,i)=1;
%                     else
%                         veryslowu(m,j,i)=(50-b(m+200,j,i))/4;
%                     end
%                 end
%             end
%         end
%     end
% end
% for i=1:51
%     for j=1:31
%         for m=1:5
%             if  b(m,j,i)<16 || b(m,j,i)>24
%                 vveryfasti(m,j,i)=0;
%             else if  b(m,j,i)<20
%                     vveryfasti(m,j,i)= (b(m,j,i)-16)/4;
%                 else if b(m,j,i)==20
%                         vveryfasti(m,j,i)=1;
%                     else
%                         vveryfasti(m,j,i)=(24-b(m,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m,j,i)<21 || b(m,j,i)>29
%                 veryfasti(m,j,i)=0;
%             else if  b(m,j,i)<25.5
%                     veryfasti(m,j,i)= (b(m,j,i)-21)/4.5;
%                 else if b(m,j,i)==25.5
%                         veryfasti(m,j,i)=1;
%                     else
%                         veryfasti(m,j,i)=(29-b(m,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m,j,i)<26 || b(m,j,i)>32
%                 fasti(m,j,i)=0;
%             else if  b(m,j,i)<29
%                     fasti(m,j,i)= (b(m,j,i)-26)/3;
%                 else if b(m,j,i)==29
%                         fasti(m,j,i)=1;
%                     else
%                         fasti(m,j,i)=(32-b(m,j,i))/3;
%                     end
%                 end
%             end
%             if  b(m,j,i)<30 || b(m,j,i)>37
%                 moderatei(m,j,i)=0;
%             else if  b(m,j,i)<33.5
%                     moderarei(m,j,i)= (b(m,j,i)-30)/3.5;
%                 else if b(m,j,i)==33.5
%                         moderatei(m,j,i)=1;
%                     else
%                         moderatei(m,j,i)=(37-b(m,j,i))/3.5;
%                     end
%                 end
%             end
%             if  b(m,j,i)<36 || b(m,j,i)>44
%                 slowi(m,j,i)=0;
%             else if  b(m,j,i)<40
%                     slowi(m,j,i)= (b(m,j,i)-36)/4;
%                 else if b(m,j,i)==40
%                         slowi(m,j,i)=1;
%                     else
%                         slowi(m,j,i)=(44-b(m,j,i))/4;
%                     end
%                 end
%             end
%             if  b(m,j,i)<42 || b(m,j,i)>50
%                 veryslowi(m,j,i)=0;
%             else if  b(m,j,i)<46
%                     veryslowi(m,j,i)= (b(m,j,i)-42)/4;
%                 else if b(m,j,i)==46
%                         veryslowi(m,j,i)=1;
%                     else
%                         veryslowi(m,j,i)=(50-b(m,j,i))/4;
%                     end
%                 end
%             end
%         end
%     end
% end
% for i=1:51
%     for m=1:200
%         for n=1:1200
% speed(n:n+5,:,i)=[vveryfast(m,:,i);veryfast(m,:,i);fast(m,:,i);moderate(m,:,i);slow(m,:,i);veryslow(m,:,i)];
% for i=1:51
% for j=1:31
% speed(find(max(speed(:,j,i))))=1;
% end
% end
% speedu(n:n+5,:,i)=[vveryfastu(m,:,i);veryfastu(m,:,i);fastu(m,:,i);moderateu(m,:,i);slowu(m,:,i);veryslowu(m,:,i)];
% for i=1:51
% for j=1:31
% speedu(find(max(speedu(:,j,i))))=1;
% end
% end
%     end
%     end
% end
% for i=1:51
%     for m=1:5
%         for n=1:30
% speedi(n:n+5,:,i)=[vveryfasti(m,:,i);veryfasti(m,:,i);fasti(m,:,i);moderatei(m,:,i);slowi(m,:,i);veryslowi(m,:,i)];
% for i=1:51
% for j=1:31
% speedi(find(max(speedi(:,j,i))))=1;
% end
% end
%     end
% end
% end


%**************方法11************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法12************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% c=b(1:200,:,:);
% for i=1:51
%     C(i,:)=std(c(:,:,i));
% end
% for i=1:51
%     for m=1:200
%         zscoreu(m,:,i)=(b(m+200,:,i)-means(i,:))./C(i,:);
%     end
% end
% for i=1:51
%     for k=1:5
%         zscorei(k,:,i)=(b(k,:,i)-means(i,:))./C(i,:);
%     end
% end
% userscore=zeros(51,200);
% imposterscore=zeros(51,5,51);
% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             if i==j
%                 for m=1:1:200
%                     for q=1:31
%                         if zscoreu(m,q,i)>1.96
%                             userscore(i,m)=userscore(i,m)+1;
%                         else
%                             userscore(i,m)=userscore(i,m);
%                         end
%                     end
%                 end
%             else
%                 for q=1:31
%                     if zscoreu(k,q,i)>1.96
%                         imposterscore(j,k,i)=imposterscore(j,k,i)+1;
%                     else
%                         imposterscore(j,k,i)=imposterscore(j,k,i);
%                     end
%                 end
%             end
%         end
%     end
% end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=0:0.1:15
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)==0)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%**************方法12************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%



%**************方法13************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
% load fisheriris
% xdata=[];
% for i=1:51
%     xdata = [xdata;b(1:200,:,i)];
% end
% % for i=1:51
% %     for j=1:51
% %         if i~=j
%             % xdata=[xdata;b(1:200,:,i+1)];
%             testdata=b(201:400,:,1);
%             group = [ones(200,1);-1*ones(10000,1)];
%             option = optimset('MaxIter',30000);
%             svm_struct = svmtrain(xdata,group, 'Kernel_Function', 'rbf', 'quadprog_opts', option )%'showplot',true);
%              TestSVM_Parameter.v=0.5;
%              Group = svmclassify(svm_struct,testdata,'Showplot',true);
% %         end
% %     end
% % end

%**************方法13************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%




%**************方法14************%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%*****%***%*****%*****%*****%*****%
%  c=b(1:200,:,:);
% X=zeros(200,31);
% for i=1:51
%     for j=1:51
%         X=b(1:200,:,i);
%         %         opts = statset('Display','final');
%         [IDX,C,sumd,D] = kmeans(X',3);%,'Distance','city','Replicates',3,'Options',opts);
%         D=D';
%         if i==j
%             for m=1:200
%                 user(1)=norm(b(m+200,:,i)-D(1,:));
%                 user(2)=norm(b(m+200,:,i)-D(2,:));
%                 user(3)=norm(b(m+200,:,i)-D(3,:));
%                 userscore(i,m)=min(user(:));
%             end
%                 else
%                     for k=1:5
%                         imposter(1)=norm(b(k,:,i)-D(1,:));
%                         imposter(2)=norm(b(k,:,i)-D(2,:));
%                         imposter(3)=norm(b(k,:,i)-D(3,:));
%                         imposterscore(j,k,i)=min(user(:));
%                     end
%             end
%         end
%     end
% onehit=[];
% %yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)));
% % imposterscore=imposterscore(:,:,19);
% % userscore=userscore(19,:);
% 
% nn=zeros(50,5);np=zeros(50,5);
% pn=zeros(1,200);pp=zeros(1,200);
% jieguo=zeros(51,1);
% for yuzhi=1:0.1:64
%     for i=1:51
%         iposterscore=imposterscore(:,:,i);
%         iposterscore(i,:)=[];
%         for k=1:50
%             for j=1:5
%                 for m=1:200
%                     if(userscore(i,m)>yuzhi)
%                         pn(1,m)=1;
%                     else pp(1,m)=1;
%                     end
%                 end
%                 if(iposterscore(k,j)>=yuzhi)%&&imposterscore(k,j)~=0)
%                     nn(k,j)=1;
%                 else if (iposterscore(k,j)<yuzhi)%&&imposterscore(k,j)~=0)
%                         np(k,j)=1;
%                     end
%                 end
%             end
%         end
%         hitrate=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
%         falserate=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% %         plot(hitrate,falserate,'.-')
% %         axis([0 1 0 1])
% %         hold on
%         if (1-hitrate-falserate<0.001)
%             jieguo(i,1)=falserate;
%         end
%           if((1-hitrate)<0.001)
%               onehit=[onehit,falserate];
%           end
%         nn=zeros(50,5);np=zeros(50,5);
%         pn=zeros(1,200);pp=zeros(1,200);
%     end
% end
% equal=mean(jieguo(:))
% zeromiss=min(onehit(:))
%         
% 
% 
% 
% 
% 
% 












% % % % % % % 
% % % % % % %  yu=((sum(imposterscore(:))/(length(imposterscore(:))-255))+mean(userscore(:)))/2;
% % % % % % % % imposterscore=imposterscore(:,:,19);
% % % % % % % %  imposerscore(19,:)=[];
% % % % % % % %  imposterscore=mean(imposterscore,2);
% % % % % % % % userscore=userscore(19,:);
% % % % % % % % userscore=userscore(:,1:5);
% % % % % % % % userscore=mean(userscore,2);
% % % % % % % % imposterscore=imposterscore(:,:,1);
% % % % % % % % userscore=userscore(1,:);
% % % % % % % %  nn=zeros(51,5);pn=zeros(51,200);pp=zeros(51,200);np=zeros(51,5);
% % % % % % % %  for i=1:51
% % % % % % % %      for k=1:51
% % % % % % % %          for j=1:5
% % % % % % % %              for yuzhi=0:0.1:yu
% % % % % % % %                  if(imposterscore(k,j,i)>=yuzhi&&imposterscore(k,j,i)~=0)
% % % % % % % %                      nn(k,j)=nn(k,j)+1;
% % % % % % % %                  else if (imposterscore(k,j,i)<yuzhi&&imposterscore(k,j,i)~=0) np(k,j)=np(k,j)+1;
% % % % % % % %                      end
% % % % % % % %                  end
% % % % % % % %              end
% % % % % % % %          end
% % % % % % % %      end
% % % % % % % %  end
% % % % % % % % for i=1:51
% % % % % % % %     for j=1:200
% % % % % % % %         if(userscore(i,j)>yuzhi)
% % % % % % % %             pn(i,j)=pn(i,j)+1;
% % % % % % % %         else pp(i,j)=pp(i,j)+1;
% % % % % % % %         end
% % % % % % % %     end
% % % % % % % % end
% % % % % % % hitrate=zeros(51,1);
% % % % % % % falserate=zeros(51,1);
% % % % % % % nn=zeros(51,5);np=zeros(51,5);
% % % % % % % pn=zeros(51,200);pp=zeros(51,200);
% % % % % % %  for yuzhi=yu/1000:0.1:yu*10
% % % % % % %    % for i=1:51
% % % % % % %         for k=1:51
% % % % % % %             for j=1:5
% % % % % % %                 for m=1:200
% % % % % % %                     if(userscore(19,m)>yuzhi)
% % % % % % %                         pn(k,m)=1;
% % % % % % %                     else pp(k,m)=1;
% % % % % % %                     end
% % % % % % %                 end
% % % % % % %                 if(imposterscore(k,j,19)>=yuzhi&&imposterscore(k,j,19)~=0)
% % % % % % %                     nn(k,j)=1;
% % % % % % %                 else if (imposterscore(k,j,19)<yuzhi&&imposterscore(k,j,19)~=0)
% % % % % % %                     np(k,j)=1;
% % % % % % %                     end
% % % % % % %                 end
% % % % % % %             end
% % % % % % %         %end
% % % % % % %     end
% % % % % % %     hitrate(k,1)=(sum(nn(:)))/(sum(np(:))+sum(nn(:)));
% % % % % % %     falserate(k,1)=(sum(pn(:)))/(sum(pn(:))+sum(pp(:)));
% % % % % % % %     yuzhi=yu/1000:0.1:yu*10;
% % % % % % % %     plot(hitrate,falserate,'.');
% % % % % % % %     axis([0 1 0 1])
% % % % % % % %     hold on
% % % % % % %  end
% % % % % % % % for i=1:51
% % % % % % % %     for j=1:200
% % % % % % % % 
% % % % % % % % end   
% % % % % % %     yuzhi=yu/1000:0.1:yu*10;
% % % % % % %     plot(hitrate,falserate,'.');
% % % % % % %     axis([0 1 0 1])
% % % % % % %     hold on
% % % % % % % 









% 
% userscore=mean(userscore,2);
% w=mean(imposterscore,2);
% w=reshape(w,51,51);
%   w1=w(:,1);
% w1=mapminmax(w1,0,1);
% userscore = mapminmax(userscore,0,1);
%  yuzhi=mean(userscore(:));
% for i=1:51
%     if userscore>=yuzhi
%         userscore(i,1)=1;
%     else userscore(i,1)=0;
%     end
% end

% for i=1:1:51
%     for j=1:1:51
%         for k=1:1:5
%             c=0;
%             if i~=j
%                 c=c+(imposterscore(j,k,i)) ; iposterscore(i,j)=c/5;
%             end
%         end
%     end
% end
%     
% 

%     %[tpr,fpr,thresholds]=roc(userscore,w);
%   


