print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP5 : FACTORISATION COMPLETE DE POLYNOMES UNIVARIEES                        #
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
# BERLEKAMP
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

F3 = FiniteField(3)
Pol3.<x> = PolynomialRing(F3)
f = x^3 - x^2 - 1

# Code pour l'EXERCICE

x3 = Pol3(0)
x6 = Pol3(0)
Q = matrix(F3,3)

b1 = vector(F3,[1,0,0])
b2 = vector(F3,[0,1,1])

L = []

def myB(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = [f]
#    assert(Set(retour) == Set(g for g,_ in list(f.factor())))
    return retour

def myFactor(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = [(f,1)]
#    assert(Set(retour) == Set(list(f.factor())))
    return retour


# # Affichage des resultats


print("\n$1a/ x^3 vaut",x3," et x^6 vaut",x6)
print("La matrice de Petr Berlekamp est")
print(Q)

print("\n$1b/ On a Q * b1 - b1 = ")
print(Q*b1-b1)
print("et Q * b2 - b2 = ")
print(Q*b2-b2)


reset()
print("""\
# ****************************************************************************
# RELEVEMENT DE HENSEL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

PolZZ.<x> = PolynomialRing(ZZ)
m = 5
f = x^4-1
g = x^3+2*x^2-x-2
h = x-2
d,ss,tt = xgcd(g,h)
s=PolZZ(ss/mod(d,m)); t=PolZZ(tt/mod(d,m))

# Code pour l'EXERCICE



def polynomeCentre(f):
    Pol=f.parent()
    x=Pol.gen()
    retour = f
    return retour


def myHensel(f,g,h,s,t,m):
    Pol=f.parent()
    x=Pol.gen()
    retour = g,h,s,t
    return retour

def myHenselItere(f,g,h,s,t,m,l):
    Pol=f.parent()
    x=Pol.gen()
    retour = f
    return retour

reponseQ5=""

# # Affichage des resultats

print("\n$1b/ Relèvement de ",f,"= (",g,")*(",h,")")
print(myHensel(f,g,h,s,t,m))
print(reponseQ5)


reset()
print("""\
# ****************************************************************************
# FACTORISATION AVEC LLL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p=13
k=4
m=p^k

PolZZ.<x> = PolynomialRing(ZZ)
f = x^4-x^3-5*x^2+12*x-6

alpha=0
beta=0
gamma=0
delta=0
alphahat=0
betahat=0
gammahat=0
deltahat=0

u = x+7626

# Code pour l'EXERCICE




# # Affichage des resultats

print("\n$1a/ Les racines sont", alpha, beta, gamma, delta,"modulo",p)
print("\n$1b/ Les racines sont", alphahat, betahat, gammahat, deltahat,"modulo",m)


