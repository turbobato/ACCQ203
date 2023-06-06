print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP11 : CODES CORRECTEURS D'ERREURS ALGEBRIQUES                              #
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
# CODE DE HAMMING
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

C = codes.HammingCode(GF(2),3)

# Code pour l'EXERCICE

B = matrix() # a completer
d = 0 # a completer

# # Affichage des resultats

print( "Le code",C,"a pour matrice")
print( B)
print( "et pour distance minimale d=",d)


reset()
print("""\
# ****************************************************************************
# DECODAGE DE BERLEKAMP-MASSEY
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

from sage.matrix.berlekamp_massey import berlekamp_massey

q=13
Fq = FiniteField(q)
k=5
alpha=Fq(6)
PolFq.<x> = PolynomialRing(Fq)
r = vector(Fq,[5,2,9,9,1,11,7,5,7,4,3,1])

# Code pour l'EXERCICE

G = matrix()
H = matrix()
s = vector(Fq,0)
sigma = PolFq(0)
M = []
m = vector(Fq,0)

# # Affichage des resultats

print( "La matrice génératrice du code est")
print( G)
print( "La matrice de controle du code est")
print( H)
print( "Le syndrome est")
print( s)
print( "Le polynome localisateur d'erreurs est")
print( sigma)
print( "La position des erreurs est")
print( M)
print( "Le message envoye le plus probable est")
print( m)



reset()
print("""\
# ****************************************************************************
# DECODAGE EN LISTE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

q=23
Fq = FiniteField(q)
k = 3
alpha=Fq(14)
MPol.<x,y>=PolynomialRing(Fq,2)
 
r=vector(Fq, [12,18,15,22,17,5,14,21,17,4,13,8,4,10, 15,11,22,12,13,9,14,12])

# Code pour l'EXERCICE

b1=0
b2=0 

L = []
M = [""]
c = vector(Fq,0)
m = ""

# # Affichage des resultats

print( "Le decodage unique fonctionne jusqu'à distance",b1)
print( "Le decodage de Sudan fonctionne jusqu'à distance",b2)
print( "La liste des mots de code les plus proches de r est",L)
print( "Elle correspond aux messages")
print( M)
print( "Le mot de code le plus probable est",c)
print( "soit le message",m)


reset()
print("""\
# ****************************************************************************
# CODE ALGEBRIQUE
# ****************************************************************************
""")


# ESSAYEZ DE LE TRAITER
# CET EXERCICE NE SERA PAS EVALUE
# IL VOUS MANQUE LE THEOREME DE RIEMANN-ROCH POUR TOUT COMPRENDRE


reset()
print("""\
# ****************************************************************************
# BORNES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

q=49

# Code pour l'EXERCICE

gv = 1/2
plotkin = 1
hamming = .9
mrrw = .8

# # Affichage des resultats

plot([gv,plotkin,hamming,mrrw],xmin=0,xmax=1,ymin=0,ymax=1, legend_label=["GV","Plotkin","Hamming","MRRW"],title="Differentes bornes sur les codes")

print("""\
# ****************************************************************************
# BORNES BATTANT GILBERT-VARSHAMOV
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# Code pour l'EXERCICE

codesalg = .7

# # Affichage des resultats

plot([gv,plotkin,hamming,mrrw,codesalg],xmin=0,xmax=1,ymin=0,ymax=1, legend_label=["GV","Plotkin","Hamming","MRRW","Codes Algebriques"],title="Differentes bornes sur les codes")
