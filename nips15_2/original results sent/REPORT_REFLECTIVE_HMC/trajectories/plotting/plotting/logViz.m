l = 100;
%l = 10;
%eps = 0.02;
eps = 0.1;
%log_path = ['BaselineHMC.l', num2str(l), '.eps', num2str(eps), '.log'];
log_path = ['ReflectiveHMC.l', num2str(l), '.eps', num2str(eps), '.log'];

% parsing info file:
data = load(log_path);

vis = 'on';
figure('visible', vis);
hold on;

count = 0;

breaks = find(data(:,1)~=-1);
start = 1;
for n=1:length(breaks)
    count = count + 1;
    if count==40
        daend = breaks(n-1);
        break
    end
    
    finish = breaks(n);
    data(finish,1)
    
    if data(finish,1)==0
        myalpha = .2;
        color = [1 .2 .2];
        style = '-';
    else
        myalpha = .2;
        color = [.2 .2 1];
        style = '-';
    end
    patchline(data(start:finish,4),data(start:finish,5),'linestyle',style,'edgecolor',color,'LineWidth',1.5,'edgealpha',myalpha)
    
    if data(finish,1)==0
        start = finish+1;
    else
        start = finish;
    end
end

plot([-3 3 3 -3 -3],[-3 -3 3 3 -3],'--','Color',[.6 .6 .6])

% [X Y] = meshgrid(-6:.1:6, -6:.6:6);
% E = 0*X;
% for i=1:size(X,1)
%     for j=1:size(X,2)
%         x = [X(i,j); Y(i,j)];
%         if norm(x,inf) <= 3
%             E(i,j) = norm(x,2);
%         else
%             E(i,j) = 1 + norm(x,2);
%         end
%     end
% end
% keyboard


%accepted = data(data(:,2)==0, :);
%%scatter(accepted(:,4),accepted(:,5), 2);
%accepted = data(data(:,2)==0, :);
%scatter(accepted(:,4),accepted(:,5), 1, [1, 0, 0]);
%plot(acceped(:,4),accepted(:,5),'LineColor',[.5 .5 .5]);
%plot(accepted(:,4),accepted(:,5),'Color',[1 .6 .6]);


%accepted = data(data(:,2)==1, :);
%scatter(accepted(:,4),accepted(:,5), 1, [0, 0, 1]);
%plot(accepted(:,4),accepted(:,5),'Color',[.6 .6 1]);

accepted = data(data(:,1)==0, :);
%scatter(accepted(:,4),accepted(:,5), 7*2, [1, 0, 0],'o', 'filled');
%plot(accepted(:,4),accepted(:,5), 'x', 'Color',[1, .2, .2],'MarkerSize',10);

data = data(1:daend,:);

accepted = data(data(:,1)>0, :);
%scatter(accepted(:,4),accepted(:,5), 7*2, [0, 0, 1],'+', 'filled');
plot(accepted(:,4),accepted(:,5), 'o', 'Color',[.2, .2, 1],'MarkerSize',5);

axis equal
xlim([-6 6]);
ylim([-6 6]);

font_size = 18;
xlabel('q_1', 'FontSize', font_size);
ylabel('q_2', 'FontSize', font_size);

%other_data = load([current_path, 'other_scatter2D.txt']);
%scatter(other_data(:,1),other_data(:,2), 'red', 'x');
%legend({'Symbolic Gibbs', 'Anglican'}, 'Location','southeast');

hold off;


%figure('Name', 'data 1');
%hold on;
%hist(data(:,1));
%hold off;

%figure('Name', 'data 2');
%hold on;
%hist(data(:,2));
%hold off;


%generate pdf:

eps_file = [log_path '.scatter2D.eps'];
png_file = [log_path '.scatter2D.png'];
pdf_file = [log_path '.scatter2D.pdf'];
svg_file = [log_path '.scatter2D.svg'];
%print('-depsc', eps_file,'-r1000');
print('-dpng',  png_file,'-r600');
%print('-dpdf',  pdf_file,'-r300');
%print('-dsvg',  svg_file,'-r1000');

%fix_lines(eps_file)
%system(['sh convert_images.sh ' f]);
disp(eps_file);

%system(['epstopdf ', eps_file]);



