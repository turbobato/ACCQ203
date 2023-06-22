print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP14 : LOG DISCRET ET COUPLAGES                                             #
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
# PAS DE BEBE, PAS DE GEANT
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p1 = 1823
Fp1 = FiniteField(p1)
b1 = Fp1(3)
x1 = Fp1(693)

p2 = 239
Fp2 = FiniteField(p2)
b2 = Fp2(2)
x2 = Fp2(15)


# Code pour l'EXERCICE

def Shanks(x,b):
    Fp = x.parent()
    return log(x,b)


# # Affichage des resultats

print("Question 2 :", Shanks(x1,b1))
print("Question 3 :", Shanks(x2,b2))




reset()
print("""\
# ****************************************************************************
# RHO DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p= 281
Fp = FiniteField(p)
x1 = Fp(263) 
b1 = Fp(239)
x2 = Fp(165)
b2 = Fp(127)
x3 = Fp(210)
b3 = Fp(199)


# Code pour l'EXERCICE

def rho(x,b):
    Fp = x.parent()
    return log(x,b)


# # Affichage des resultats

print("Le log de x=",x1,"en base",b1,"vaut",rho(x1,b1),".")
print("Le log de x=",x2,"en base",b2,"vaut",rho(x2,b2),".")
print("Le log de x=",x3,"en base",b3,"vaut",rho(x3,b3),".")





reset()
print("""\
# ****************************************************************************
# COUPLAGE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p = 61
Fp = FiniteField(p)
E = EllipticCurve(Fp,[11,0])
print("groupe de E=", E.abelian_group()) # pour verifier
S = E(24,34)
T = E(5,27)
r = 10
print("Verification de la r-torsion : r*S =", r*S, "et r*T =", r*T)


# Code pour l'EXERCICE

def myLine(P1,P2,S):
    E=P.curve()
    x1=P1[0]; y1=P1[1]; z1=P1[2]
    x2=P2[0]; y2=P2[1]; z2=P2[2]
    xS=S[0]; yS=S[1]; zS=S[2]
    return 1
    
def myH(P1,P2,S):
    return 1

def myMiller(r,S,P):
    return 1

def myTatePairing(S,T,r):
    return 1


# # Affichage des resultats

print("Calcul du couplage", myTatePairing(S,T,r))



reset()
print("""\
# ****************************************************************************
# ATTAQUE M.O.V.
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p = 2199023255579
Fp = FiniteField(p)
E = EllipticCurve(Fp,[1,0])
P = E(1435967701832 , 123951463462)
Q = E(1129476910351 , 1383670460733)

# Code pour l'EXERCICE

j = 0 # j-invariant a faire calculer par une fonction de SageMath
rep2 = "commentaire"
t = 2 # Ecrire le code pour calculer cette valeur
q = p^t
Fq.<alpha> = FiniteField(q)
EE = EllipticCurve(Fq,[1,0])
PP = EE(1435967701832 , 123951463462)
QQ = EE(1129476910351 , 1383670460733)
SS = EE(0) # point a calculer vous-meme
zeta1 = 1
zeta2 = 1
lambd = 1


# # Affichage des resultats

print("p premier ?",p.is_prime())
print("j-invariant de E :",j)
print("p mod 4 =", mod(p,4))
print(rep2)
print("Cardinal de E(Fp) :",E.cardinality(),"=",E.cardinality().factor())
print("Ordre de P :",P.order())
print("Cardinal de E(Fq) :",EE.cardinality(),"=",EE.cardinality().factor())
print("Point S :",SS)
print("On calcule zeta1 =",zeta1,", zeta2 =",zeta2,", lambda =",lambd,".")




reset()
print("""\
# ****************************************************************************
# CALCUL D'INDICE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p = 439
Fp = FiniteField(p)
g = Fp(237)
b = Fp(136)
y = 11

# Code pour l'EXERCICE

def LogIndice(g,b,y):
    return log(g,b)

# # Affichage des resultats

print("Le log de g=",g,"en base",b,"vaut",LogIndice(g,b,y),".")

