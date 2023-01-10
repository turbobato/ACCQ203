print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP3 : RESEAUX EUCLIDIENS                                                    #
# *************************************************************************** #
# *************************************************************************** #
""")

# CONSIGNES
#
# Les seules lignes a modifier sont annoncee par "Code pour l'exercice"
# indique en commmentaire et son signalees
# Ne changez pas le nom des variables
#
# CONSEILS
#
# Ce modele vous sert a restituer votre travail. Il est deconseille d'ecrire
# une longue suite d'instruction et de debugger ensuite. Il vaut mieux tester
# le code que vous produisez ligne apres ligne, afficher les resultats et
# controler que les objets que vous definissez sont bien ceux que vous attendez.
#
# Vous devez verifier votre code en le testant, y compris par des exemples que
# vous aurez fabrique vous-meme.
#


reset()
print("""\
# ****************************************************************************
# BASE D'UN RESEAU
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
        [ 2, -3,  4, 0],
        [ 4,  4, 53, -5]])

# Code pour l'EXERCICE

ker = A.right_kernel()

L = ker.basis()

L = [vector(vect)[:-1] for vect in L ]

# # Affichage des resultats

print("\n$ Le réseau a pour base")
print(L)


reset()
print("""\
# ****************************************************************************
# APPLICATIONS NUMERIQUES
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

n1 = round(arctan(1),50)
n2 = round(arctan(1/5),50)
n3 = round(arctan(1/239),50)

r=-2.5468182768840820791359975088097915

Pol.<x>=PolynomialRing(ZZ)

# Code pour l'EXERCICE

alpha=[0,0,0] 
rr = [r^i for i in range(4)] 
M=10000
B = matrix(ZZ, [[1,0,0,round(M*n1)],
                [0,1,0,round(M*n2)],
                [0,0,1,round(M*n3)]])
v = B.LLL()[0][:-1]
alpha = list(v)

BB = matrix(ZZ, [[1 if i==j else 0 for i in range(len(rr))]+[round(M*rr[j])] for j in range(len(rr))])
vv = BB.LLL()[0][:-1]
p = sum([vv[i]*x^i for i in range(len(vv))])
# # Affichage des resultats

print("\n$ La relation de Machin est alpha1*n1+alpha2*n2+alpha3*n3=0 avec")
for i in range(3):
   print("alpha",i+1,"=",alpha[i])

print("\n$ Un polynome minimal plausible est")
print(p)
print("dont les racines sont")
print(p.roots(ring=RR,multiplicities=false))




reset()
print("""\
# ****************************************************************************
# ALGORITHME LLL
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

B = matrix(ZZ,[[  9, -25],
               [ -5,  14],
               [  4, -11]])

# Code pour l'EXERCICE

def myLLL(M):
    B = copy(M)
    n = B.ncols()
    repeter = true
    while repeter : 
        Betoile, mu = B.transpose().gram_schmidt(orthonormal=false)
        Betoile = Betoile.transpose()
        mu = mu.transpose()
        # ECRIRE L'ETAPE DE REDUCTION
        for i in range(1,n):
            for j in range(i-1,-1,-1):
                B[:,i] = B[:,i] - round(mu[j,i])*B[:,j]
                mu[:,i] = mu[:,i] - round(mu[j,i])*mu[:,j]
        echange = False
        i=0
        while i <= n-2 and not echange :
            if (Betoile[:,i].norm())**2 > 2*(Betoile[:,i+1].norm())**2 :
                echange = True
                B[:,i], B[:,i+1] = B[:,i+1], B[:,i]
            i+=1
        if not echange :
            repeter = False
    assert(B==Betoile*mu)
    assert(all(mu[i,j]<=1/2 for i in range(n) for j in range(i+1,n)))
    assert(all(mu[i,j]>=-1/2 for i in range(n) for j in range(i+1,n)))
    return B


# # Affichage des resultats

print("\n$ Une base LLL de B est")
print(myLLL(B))

reset()
print("""\
# ****************************************************************************
# RESEAUX CLASSIQUE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

n = 8
e = vector([1/2]*8)

# Code pour l'EXERCICE

def gram_matrix(A):
    return matrix(ZZ,[[vector(A[:,i]).dot_product(vector(A[:,j])) for j in range(A.ncols())] for i in range(A.ncols())])

A = matrix(ZZ,[[1 for i in range(n+1)]])
An = matrix(ZZ, A.right_kernel().basis()).transpose()
an = gram_matrix(An).det()
D = matrix(ZZ,[[1 for i in range(n)]+[-2]])
Dn = matrix(ZZ, D.right_kernel().basis()).transpose()
Dn = Dn[:-1,:]
dn = gram_matrix(Dn).det()
E = IntegralLattice(identity_matrix(8),Dn.transpose())+IntegralLattice(identity_matrix(8),matrix(e))
E8 = matrix(QQ,E.basis()).transpose()
e8 = gram_matrix(E8).det()


reponse6 = '''\nClairement, étant donné la base de E8, dans la décomposition de x appartenant à E8, soit (1/2,...,1/2) \
apparaît avec un scalaire pair et les coordonées sont alors toutes entières, soit il apparait avec un scalaire \
impair et toutes les coordoonées du vecteur final sont demi entières''' 
reponse7_an = IntegralLattice(identity_matrix(9),An.transpose()).short_vectors(3)[2]
reponse7_dn = IntegralLattice(identity_matrix(8),Dn.transpose()).short_vectors(3)[2]
reponse7_e8 = IntegralLattice(identity_matrix(8),E8.transpose()).short_vectors(3)[2]
reponse8 = len(reponse7_e8)

# # Affichage des resultats

print("\n$ Une base de An est")
print(An, "de déterminant",an)

print("\n$ Une base de Dn est")
print(Dn, "de déterminant",dn)

print("\n$ Une base de E8 est")
print(E8, "de déterminant",e8)

print("\nRéponse 6 :", reponse6)
print("\nPour ne pas polluer la console, voir code pour reponse 7")
print("\nRéponse 8 :","les vecteurs minimaux sont de longueur 2, il y en a :", reponse8)

reset()
print("""\
# ****************************************************************************
# DENSITES OPTIMALES
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

def gram_matrix(A):
    return matrix(ZZ,[[vector(A[:,i]).dot_product(vector(A[:,j])) for j in range(A.ncols())] for i in range(A.ncols())])

def densite(minimum,determinant,n):
    return (pi^(n/2))/(gamma(n/2+1)*2^n)*((minimum)^(n/2))/((determinant)^(1/2))

A = matrix(ZZ,[[1 for i in range(2+1)]])
A2 = matrix(ZZ, A.right_kernel().basis()).transpose()
det_a2 = gram_matrix(A2).det()
a2 = densite(2,det_a2,2)
A = matrix(ZZ,[[1 for i in range(3+1)]])
A3 = matrix(ZZ, A.right_kernel().basis()).transpose()
det_a3 = gram_matrix(A3).det()
a3 = densite(2,det_a3,3)
D = matrix(ZZ,[[1 for i in range(4)]+[-2]])
D4 = matrix(ZZ, D.right_kernel().basis()).transpose()
D4 = D4[:-1,:]
det_d4 = gram_matrix(D4).det()
d4 = densite(2,det_d4,4)
D = matrix(ZZ,[[1 for i in range(5)]+[-2]])
D5 = matrix(ZZ, D.right_kernel().basis()).transpose()
D5 = D5[:-1,:]
det_d5 = gram_matrix(D5).det()
d5 = densite(2,det_d5,5)
e8 = densite(2,1,8)

# # Affichage des resultats

print("\n$ La densité de A2 est",a2.n())
print("\n$ La densité de A3 est",a3.n())
print("\n$ La densité de D4 est",d4.n())
print("\n$ La densité de D5 est",d5.n())
print("\n$ La densité de E8 est",e8.n())