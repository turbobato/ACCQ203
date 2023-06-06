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

Delta1 =  (M1 - x*identity_matrix(QQ,5)).smith_form()[0]
Delta2 =  (M2 - x*identity_matrix(QQ,5)).smith_form()[0]
Delta3 =  (M3 - x*identity_matrix(QQ,5)).smith_form()[0]


Invariants1 = [Delta1[i,i] for i in range(5) if Delta1[i,i] != 0]
Invariants2 = [Delta2[i,i] for i in range(5) if Delta2[i,i] != 0]
Invariants3 = [Delta3[i,i] for i in range(5) if Delta1[i,i] != 0]

Polmin1 = -Invariants1[-1]
Polmin2 = -Invariants2[-1]
Polmin3 = -Invariants3[-1]

Polcar1 = -prod(Invariants1)
Polcar2 = -prod(Invariants2)
Polcar3 = -prod(Invariants3)


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

def mat_compagnon(pol) : 
    R = pol.base_ring()
    n = pol.degree()
    M = matrix(R,n)
    for i in range(n):
        for j in range(n):
            if j == n-1 :
                M[i,j] = -pol[i]
            elif j == i-1 :
                M[i,j] = 1
            else : 
                M[i,j] = 0
    return M


Frob1 = block_matrix([[mat_compagnon(Invariants1[i]) if i == j else 0 for i in range(len(Invariants1))] for j in range(len(Invariants1))])
Frob2 = block_matrix([[mat_compagnon(Invariants2[i]) if i == j else 0 for i in range(len(Invariants2))] for j in range(len(Invariants2))])
Frob3 = block_matrix([[mat_compagnon(Invariants3[i]) if i == j else 0 for i in range(len(Invariants3))] for j in range(len(Invariants3))])

# # Affichage des resultats

print("La forme de Frobenius de M1 est\n", Frob1)
print( "vérification Sagemath \n", M1.rational_form())
print("La forme de Frobenius de M2 est\n", Frob2)
print("vérification Sagemath \n", M1.rational_form())
print("La forme de Frobenius de M3 est\n", Frob3)
print( "vérification Sagemath \n", M3.rational_form())
print("""\
# ****************************************************************************
# FORME DE JORDAN D'UNE MATRICE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# idem exercice précédent

# Code pour l'EXERCICE

factos1 = [factor for pol in Invariants1 for factor in list(pol.factor())]
factos2 = [factor for pol in Invariants2 for factor in list(pol.factor())]
factos3 = [factor for pol in Invariants3 for factor in list(pol.factor())]


Jordan1 = block_matrix([[jordan_block(-factos1[i][0][0],factos1[i][1]) if i==j else 0 for i in range(len(factos1))]for j in range(len(factos1))])
Jordan2 = block_matrix([[jordan_block(-factos2[i][0][0],factos2[i][1]) if i==j else 0 for i in range(len(factos2))]for j in range(len(factos2))])
Jordan3 = block_matrix([[jordan_block(-factos3[i][0][0],factos3[i][1]) if i==j else 0 for i in range(len(factos3))]for j in range(len(factos3))])

# # Affichage des resultats

print("La forme de Jordan de M1 est\n", Jordan1)
print( "vérification Sagemath \n", M1.jordan_form())
print( "La forme de Jordan de M2 est\n", Jordan2)
print( "vérification Sagemath \n", M2.jordan_form())
print( "La forme de Jordan de M3 est\n", Jordan3)
print( "vérification Sagemath \n", M3.jordan_form())


reset()
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
    c, cstar = PolFq(1), PolFq(1)
    l, dstar = 0, Fq(1)
    m = -1
    n = len(r)
    for k in range(n) :
        d = r[k]+sum(c[i]*r[k-i] for i in range(1,l+1))
        if d != 0 : 
            t = c
            c = c - d*(dstar^(-1))*cstar*x^(k-m)
            if l <= k/2 :
                l = k+1 - l
                cstar = t
                dstar = d
                m = k
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
    R = PolFq.quotient(chi)
    n = Fq.cardinality()^(chi.degree())-1
    m = ceil(sqrt(n))
    T = []
    e = R(1)
    for j in range(m) :
        T.append(e)
        e = e*R(x)
        if j > 0 and e == R(1) :
            return j
    h = R(x)^(-m)
    gamma = h
    for i in range(1,m) :
        for j in range(m) :
            if gamma == T[j] :
                return i*m + j
        gamma = gamma*h


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

