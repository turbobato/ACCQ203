print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP10 : INVARIANTS DE SIMILITUDE ET LFSR                                     #
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
# INVARIANTS DE SIMILITUDE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

PolQQ.<x>=PolynomialRing(QQ)

M1 =  matrix(QQ,[[-1841, -10363, 22304, 108021, -243809 ],
[1366, 7695, -16535, -80130, 180869 ],[
-1072, -6088, 13069, 63408, -143144 ],[
506, 2951, -6298, -30700, 69343 ],[
82, 502, -1061, -5214, 11788]])

M2 = matrix(QQ,[[570, 1652, -8251, 3807, 34007 ],[
-178, -522, 2666, -1196, -10988 ],[
540, 1573, -7866, 3622, 32430 ],[
-42, -118, 580, -275, -2387 ],[
135, 393, -1967, 905, 8109]])

M3 = matrix(QQ,[[64, -300, 924, -228, 3168 ],[
-80, 404, -1232, 304, -4224 ],[
35, -175, 543, -133, 1848 ],[
-15, 75, -231, 61, -792 ],[
-20, 100, -308, 76, -1052]])


# Code pour l'EXERCICE

Delta1 =  matrix(QQ,5)
Delta2 =  matrix(QQ,5)
Delta3 =  matrix(QQ,5)

Invariants1 = [PolQQ(0)]
Invariants2 = [PolQQ(0)]
Invariants3 = [PolQQ(0)]

Polmin1 = PolQQ(0)
Polmin2 = PolQQ(0)
Polmin3 = PolQQ(0)

Polcar1 = PolQQ(0)
Polcar2 = PolQQ(0)
Polcar3 = PolQQ(0)


# # Affichage des resultats

print("La forme normale de M1 est\n", Delta1)
print("La forme normale de M2 est\n", Delta2)
print( "La forme normale de M3 est\n", Delta3)

print( "\nLes invariants de similitude de M1 sont\n", Invariants1)
print( M1.rational_form(format='invariants'))
print( "Les invariants de similitude de M2 sont\n", Invariants2)
print( M2.rational_form(format='invariants'))
print( "Les invariants de similitude de M3 sont\n", Invariants3)
print( M3.rational_form(format='invariants'))

print( "\nLe polynôme minimal de M1 est ",Polmin1)
print( "et d'après SageMath", M1.minimal_polynomial())
print( "Le polynôme minimal de M2 est ",Polmin2)
print( "et d'après SageMath", M2.minimal_polynomial())
print( "Le polynôme minimal de M3 est ",Polmin3)
print( "et d'après SageMath", M3.minimal_polynomial())

print("Vérification p(M1)")
print( Polmin1(M1))
print( "Vérification p(M2)")
print( Polmin2(M2))
print( "Vérification p(M2)")
print( Polmin3(M3))

print("\nLe polynôme caractéristique de M1 est ",Polcar1)
print( "et d'après SageMath", M1.characteristic_polynomial())
print("\nLe polynôme caractéristique de M2 est ",Polcar2)
print( "et d'après SageMath", M2.characteristic_polynomial())
print( "\nLe polynôme caractéristique de M3 est ",Polcar3)
print("et d'après SageMath", M3.characteristic_polynomial())




print("""\
# ****************************************************************************
# FORME DE FROBENUIS D'UNE MATRICE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# idem exercice précédent

# Code pour l'EXERCICE

Frob1 = matrix(QQ,5)
Frob2 = matrix(QQ,5)
Frob3 = matrix(QQ,5)

# # Affichage des resultats

print("La forme de Frobenius de M1 est\n", Frob1)
print( "vérification Sagemath \n", M1.rational_form())
print("La forme de Frobenius de M2 est\n", Frob2)
print("vérification Sagemath \n", M1.rational_form())
print("La forme de Frobenius de M3 est\n", Frob3)
print( "vérification Sagemath \n", M3.rational_form())



print("""\
# ****************************************************************************
# BERLEKAMP-MASSEY
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

from sage.matrix.berlekamp_massey import berlekamp_massey

F2 = GF(2)
suite = [F2(1),0,1,1,0,0,0,0,1]
suite = suite+suite+suite+suite
ans = berlekamp_massey(suite)


# Code pour l'EXERCICE


def myBerlekampMassey(r):
    Fq = r[0].parent()
    PolFq.<x> = PolynomialRing(Fq)
    c = PolFq(0)
    l = 0
    return c,l
    
    

# # Affichage des resultats

q=2
Fq = FiniteField(q)
for _ in range(1):
    t=randint(1,10)
    r = [Fq.random_element() for _ in range(t) ]
    r = r+r+r+r
    p1 = berlekamp_massey(r)
    p2,_ = myBerlekampMassey(r)
    if p1.reverse()- p2 !=0:
        print("Erreur")


reset()
print("""\
# ****************************************************************************
# ORBITES D'UN LFRS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice
# Code pour l'EXERCICE
print("NE PAS TRAITER")
# # Affichage des resultats

reset()
print("""\
# ****************************************************************************
# PERIODES D'UN LFRS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

F2 = GF(2)
PolF2.<x> = PolynomialRing(F2)
chi1 = 1 + x + x^2 + x^3 + x^4
chi2 = 1 + x + x^2 + x^4
chi3 = 1 + x^3 + x^6

F5 = GF(5)
PolF5.<y> = PolynomialRing(F5)
chi4 = 3 + y^2
chi5 = 3 + 3*y + y^2


# Code pour l'EXERCICE

def BSGS(chi):
    PolFq = chi.parent()
    x = PolFq.gen()
    Fq = PolFq.base_ring()
    return 0


# # Affichage des resultats

print("Période de chi1",  BSGS(chi1))
print("Période de chi2",  BSGS(chi2))
print("Période de chi3",  BSGS(chi3))
print("Période de chi4",  BSGS(chi4))
print("Période de chi5",  BSGS(chi5))


reset()
print("""\
# ****************************************************************************
# SERIES GENERATRICES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# Code pour l'EXERCICE


print("NE PAS TRAITER")

# # Affichage des resultats

