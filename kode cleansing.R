
################### JANGAN DI RUN ###############
DescribedStudent<-DescribedStudent[!(DescribedStudent$kdsla=="\\N"),]
DescribedStudent<-DescribedStudent[!(DescribedStudent$kdsla==0),]
DescribedStudent<-DescribedStudent[!(DescribedStudent$nem<=30.0),]
DescribedStudent<-DescribedStudent[!(DescribedStudent$nem>60.0),]

School2 <- School2[-c(12),]

# membagi nemgroup
DescribedStudent$nemgroup <- NULL
DescribedStudent$nemgroup = cut(DescribedStudent$nem,c(30,35,40,45,50,55,60))

#membagi sks menjadi semester
DescribedStudent$semester <- NULL
DescribedStudent$semester <- cut(DescribedStudent$sks,c(0,20,40,60,80,100,120,
                                                        140,160,180,200,220,240))


#supaya nem bisa dibaca sampe koma nya
DescribedStudent$nem = as.numeric(as.character(DescribedStudent$nem))

#Agregat
DescribedStudent <- aggregate(DescribedStudent$ipk, 
                           by = list(DescribedStudent$nim, 
                                     DescribedStudent$kdjur, 
                                     DescribedStudent$nmjur, 
                                     DescribedStudent$kdsla, 
                                     DescribedStudent$nmsla,
                                     DescribedStudent$nem, 
                                     DescribedStudent$nemgroup,
                                     DescribedStudent$sks), max,  .keep_all= TRUE)

#menghapus baris berisikan nilai NA
IdentifiedStudent <- na.omit(IdentifiedStudent)

#menjadikan tipe data factor
IdentifiedStudent$nemgroup <- as.factor(IdentifiedStudent$nemgroup)
IdentifiedStudent$wilayah <- as.factor(IdentifiedStudent$wilayah)
IdentifiedStudent$nmjur <- as.factor(IdentifiedStudent$nmjur)
IdentifiedStudent$nmsla <- as.factor(IdentifiedStudent$nmsla)


#rename levels
levels(IdentifiedStudent$nemgroup) =  c("30.00-34.99", "35.00-39.99",
    "40.00-44.99","45.00-49.99", "50.00-54.99","55.00-60.00")
levels(IdentifiedStudent$semester) =  c("1,2,3,4,5,6,7,8,9,10,11")

#menggabungkan 2 tabel dengan salah 1 kolom yang memiliki nilai sama
IdentifiedStudent<-merge(IdentifiedStudent,Sekolah,by="kdsla")

