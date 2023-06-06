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
        [ 2, -3,  4],
        [ 4,  4, 53]])

# Code pour l'EXERCICE

L=[]

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
p = Pol(x^2-2) 
rr = 0 


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
        assert(B==Betoile*mu)
        assert(all(mu[i,j]<=1/2 for i in range(n) for j in range(i+1,n)))
        assert(all(mu[i,j]>=-1/2 for i in range(n) for j in range(i+1,n)))
        repeter = false
        # ECRIRE LE TEST D'ECHANGE
    return B


# # Affichage des resultats

print("\n$ Une base LLL de B est")
#print(myLLL(B))


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

An = matrix(ZZ,1)
an = 0 #determinant de An
Dn = matrix(ZZ,1)
dn = 0
E8 = matrix(ZZ,1)
e8 = 0


reponse6 = ""
reponse7_an = []
reponse7_dn = []
reponse7_e8 = []
reponse8 = 0

# # Affichage des resultats

print("\n$ Une base de An est")
print(An, "de déterminant",an)

print("\n$ Une base de Dn est")
print(Dn, "de déterminant",dn)

print("\n$ Une base de E8 est")
print(E8, "de déterminant",e8)


reset()
print("""\
# ****************************************************************************
# DENSITES OPTIMALES
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE


a2 = 0
a3 = 0
d4 = 0
d5 = 0
e8 = 0

# # Affichage des resultats

print("\n$ La densité de A2 est",a2)
print("\n$ La densité de A3 est",a3)
print("\n$ La densité de D4 est",d4)
print("\n$ La densité de D5 est",d5)
print("\n$ La densité de E8 est",e8)




