vundle=~/.vim/bundle/vundle

if [ ! -d "$vundle" ]; then
  git clone https://github.com/gmarik/vundle.git $vundle 
fi

vim +BundleInstall +qall

