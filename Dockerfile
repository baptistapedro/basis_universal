FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev libjpeg-dev
RUN git clone https://github.com/BinomialLLC/basis_universal.git
WORKDIR /basis_universal
RUN cmake -DCMAKE_C_COMPILER=afl-clang -DCMAKE_CXX_COMPILER=afl-clang++ .
RUN make
RUN make install
RUN mkdir /basisuCorpus
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/mozilla/012-dispose-none.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/arc.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray10.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/crosshatch30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/gray100.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hexagons.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/hs_cross.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left30.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/left45.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal2.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/horizontal3.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/objects.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/red-ball.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/t-shirt.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/vertical.png
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/png/ImageMagick/wizard.png
RUN mv *.png /basisuCorpus
ENV LD_LIBRARY_PATH=/usr/local/lib/

ENTRYPOINT ["afl-fuzz", "-i", "/basisuCorpus", "-o", "/basisuOut"]
CMD ["/basis_universal/bin/basisu", "-ktx2", "@@"]
