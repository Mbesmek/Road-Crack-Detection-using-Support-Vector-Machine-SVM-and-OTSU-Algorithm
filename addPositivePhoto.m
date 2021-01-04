function[Binarize]= addPositivePhoto(n)

pPath = 'C:\Users\Melih\Desktop\ML-Proje\Cracks\';
pDirectory = dir([pPath '/*.jpg']);
pNames = {pDirectory.name}';



%%
 pPhoto=cell(1,n);
for i=1:n

  pPhoto{i} =  rgb2gray(imread([pPath pNames{i}]));

end

for i=1:n
level = graythresh(pPhoto{1,i});
Binarize{i} = imbinarize(pPhoto{1,i},level);
end

end