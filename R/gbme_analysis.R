Y<-tListHA[[1]]
diag(Y)<-0
lab<-tLabelHA[[1]]
gbme(Y=Y, k=2, NS=500,odens=1, ofilename="OUT",fam="poisson", directed=F)
z<-as.matrix(read.table(file="Z", header=F, sep=" "))
zz<-array(z,dim=c(dim(Y)[1],500,2),c("z1","z2"))
zzz.mean<-apply(zz,c(1,3),mean)

pdf(height=5,width=5,file="latentnet.pdf")
plot(zz[,,1],zz[,,2],type="n",axes=FALSE,ylab="Latent Dimension 2", xlab="Latent Dimension 1",ylim=c(-3,4),xlim=c(-6,5))
axis(2,las= HORIZONTAL<-1)
axis(1)
points(zz[1,,1],zz[1,,2],col= "red")
points(zz[2,,1],zz[2,,2],col= "green")
points(zz[3,,1],zz[3,,2],col= "blue")
points(zz[4,,1],zz[4,,2],col= "violet")
points(zz[5,,1],zz[5,,2],col= "yellow")
points(zz[6,,1],zz[6,,2],col= "pink")
points(zz[7,,1],zz[7,,2],col= "orange")
#points(zzz.mean,col="black")
text(zzz.mean,label=lab,col="black")
dev.off()