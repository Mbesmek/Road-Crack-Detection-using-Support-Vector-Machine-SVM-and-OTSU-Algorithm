function[nPhoto]= addNegativePhoto(n)
nPath = 'C:\Users\Melih\Desktop\ML-Proje\NonCracks\';
nDirectory = dir([nPath '/*.jpg']);
Names = {nDirectory.name}';
nPhoto=cell(1,n);
for i=1:n

  nPhoto{i} = rgb2gray(imread([nPath Names{i}]));

end


for i=1:n
level = graythresh(nPhoto{1,i});
Binarize{i} = imbinarize(nPhoto{1,i},level);
end
end