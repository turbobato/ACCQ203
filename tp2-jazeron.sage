print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP2 : ALGEBRE LINEAIRE SUR UN ANNEAU PRINCIPAL                              #
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
# MISE SOUS FORME NORMALE D'HERMITE
# ****************************************************************************
""")

A = matrix(ZZ,[
        [-2,  3,  3,  1],
        [ 2, -1,  1, -3],
        [-4,  0, -1, -4]])

A1 = random_matrix(ZZ, 7, 8, algorithm='echelonizable', rank=3)

U = identity_matrix(4)

# Code pour l'EXERCICE

def cherche_pivot_non_nul(A,U,i,j):
    """
    Echange la colonne j avec une colonne à gauche pour que A[i,j] soit non nul.
    """
    # On cherche j0 tel que A[i,j0] soit non nul
    j0 = -1
    for k in range(j,-1,-1):
        if A[i,k] != 0 :
            j0 = k
            break
    # Si on trouve un tel j0, on échange les colonnes
    if j0 != -1 :
        A.swap_columns(j,j0)
        U.swap_columns(j,j0)
        return True # on renvoie True si on a trouvé un pivot
    else :
        return False # False sinon 
    
def normalise_pivot(A,U,i,j):
    """
    Multiplie la colonne j si besoin pour que A[i,j] soit positif.
    """
    if A[i,j] < 0:
        A[:,j] = A[:,j] * -1
        U[:,j] = U[:,j] * -1

def annule_a_gauche(A,U,i,j):
    """
    Annule les coefficients à gauche de A[i,j]
    """
    # On utilise des relations de Bezout :
    for k in range(j-1,-1,-1):
        a = A[i,j]
        b = A[i,k]
        d, u, v = xgcd(a,b)
        A[:,j] , A[:,k] = u * A[:,j] + v * A[:,k] , -(b/d) * A[:,j] + (a/d) * A[:,k]
        U[:,j], U[:,k] = u * U[:,j] + v * U[:,k] , -(b/d) * U[:,j] + (a/d) * U[:,k]
    
def reduit_a_droite(A,U,i,j):
    """
    Réduit les coefficients à gauche de A[i,j] modulo A[i,j]
    """
    for k in range(j+1,A.ncols()):
        quotient = A[i,k] // A[i,j]
        A[:,k] = A[:,k] - quotient * A[:,j]
        U[:,k] = U[:,k] - quotient * U[:,j]

def MyHNF(A):
    """
    Forme normale d'Hermite selon votre code
    """
    m = A.nrows()
    n = A.ncols()
    H = copy(A)
    U = identity_matrix(n)
    # ECRIVEZ VOTRE CODE ICI, VOUS POUVEZ REPRENDRE LES FONCTIONS PRECEDENTES
    # COMME SOUS-FONCTION
    l = 0
    i = m-1
    k = n-1
    while i >= l :
        if cherche_pivot_non_nul(H,U,i,k) :# on cherche un pivot et ça fait l'échange en meme temps
            normalise_pivot(H,U,i,k) # on normalise
            annule_a_gauche(H,U,i,k) # on annule a gauche
            reduit_a_droite(H,U,i,k) # on reduit a droite
            i = i-1
            k = k-1
        else : 
            i = i-1
    assert(H-A*U==0)
    return H,U

def SageHNF(A):
    """
    Forme normale d'Hermite de SAGE avec la convention francaise :
    Les vecteurs sont ecrits en colonne.
    """
    m = A.nrows()
    n = A.ncols()
    Mm = identity_matrix(ZZ,m)[::-1,:]
    Mn = identity_matrix(ZZ,n)[::-1,:]
    AA = (Mm*A).transpose()
    HH, UU = AA.hermite_form(transformation=True)
    H = (HH*Mm).transpose()*Mn
    U = UU.transpose()*Mn
    assert(H-A*U==0)
    return H,U

H,  U  = MyHNF(A)
HH, UU = SageHNF(A)

# test sur nb matrices aléatoires
def test(nb) :
    for i in range(nb):
        n = ZZ.random_element(10)
        m = ZZ.random_element(10)

        A = random_matrix(ZZ,n,m)
        H, U = MyHNF(A)
        HH, UU = SageHNF(A)
        if HH != H :
            return False
    return True


test = test(100)

# # Affichage des resultats

print("\n$ Question 4")
print("La matrice A = ")
print(A)
print("a pour forme normale d'Hermite H=")
print(H)
print("et matrice de transformation U=")
print(U)
print("\n$ Question 5")
print("D'apres SageMath, la matrice A a pour forme normale d'Hermite H=")
print(HH)
print("et matrice de transformation U=")
print(UU)
print("\n$ Question 6")
print("Les deux fonctions coincident-elles sur une centaine d'exemples ?")
print(f'Le test vaut {test}')
print("""\
# ****************************************************************************
# MISE SOUS FORME NORMALE DE SMITH
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

X1 = matrix(ZZ,2,3,[
        [4, 7, 2],
        [2, 4, 6]])

X2 = matrix(ZZ,3,3,[
        [-397, 423, 352],
        [   2,  -3,   1],
        [-146, 156, 128],
])

PolQ.<xQ> = PolynomialRing(QQ)
AQ = matrix(PolQ,3,[
            [xQ + 1,  2,     -6],
            [     1, xQ,     -3],
            [     1,  1, xQ - 4]])
Pol2.<x2> = PolynomialRing(FiniteField(2))
AF2 = matrix(Pol2,3,[
            [x2 + 1,  2,     -6],
            [     1, x2,     -3],
            [     1,  1, x2 - 4]])
Pol3.<x3> = PolynomialRing(FiniteField(3))
AF3 = matrix(Pol3,3,[
            [x3 + 1,  2,     -6],
            [     1, x3,     -3],
            [     1,  1, x3 - 4]])
Pol5.<x5> = PolynomialRing(FiniteField(5))
AF5 = matrix(Pol5,3,[
            [x5 + 1,  2,     -6],
            [     1, x5,     -3],
            [     1,  1, x5 - 4]])

# Code pour l'EXERCICE

def cherche_pivot_et_echange(A,L,U,k) :
    "Cherche un pivot non nul et fait les échanges"
    # on cherche un pivot non nul
    for i in range(k,A.nrows()):
        for j in range(k,A.ncols()):
            if A[i,j]!=0 :
                A.swap_rows(k,i)
                L.swap_rows(k,i)
                A.swap_columns(k,j)
                U.swap_columns(k,j)
                return True
    # on n'a pas trouvé de pivot, on renvoie False
    return False
    
def test_arret(A,k):
    "Vérifie le test d'arrêt de la boucle principale"
    for i in range(k+1,A.nrows()):
        if A[i,k] != 0 :
            return False
    for j in range(k+1,A.ncols()):
        if A[k,j] != 0 : 
            return False
    return True
    
def bezout_lignes(A,L,k):
    "Fait les relations de Bezout sur les lignes de A et L"
    for i in range(k+1,A.nrows()) :
        d, s, t = xgcd(A[k,k],A[i,k])
        if A[i,k] % A[k,k] == 0 :
            d = A[k,k]
            s = 1
            t = 0
        u, v = -A[i,k]/d, A[k,k]/d
        A[k,:], A[i,:] = s*A[k,:] + t*A[i,:], u*A[k,:] + v*A[i,:]
        L[k,:], L[i,:] = s*L[k,:] + t*L[i,:], u*L[k,:] + v*L[i,:]
        
def bezout_colonnes(A,U,k):
    "Fait les relations de Bezout sur les colonnes de A et U"
    for j in range(k+1,A.ncols()) :
        d, s, t = xgcd(A[k,k],A[k,j])
        if A[k,j] % A[k,k] == 0 :
            d = A[k,k]
            s = 1
            t = 0
        u, v = -A[k,j]/d, A[k,k]/d
        A[:,k], A[:,j] = s*A[:,k] + t*A[:,j], u*A[:,k] + v*A[:,j]
        U[:,k], U[:,j] = s*U[:,k] + t*U[:,j], u*U[:,k] + v*U[:,j]

def test_divisibilite(A,U,k):
    "Verifie que A[k,k] divise tout le monde dans la partie inférieure droite de la matrice, fait les opérations nécessaires"
    for i in range(k+1,A.nrows()):
        for j in range(k+1,A.ncols()):
            if A[i,j] % A[k,k] != 0 :
                A[:,k] = A[:,k] + A[:,j]
                U[:,k] = U[:,k] + U[:,j]
                return
    
def MySNF(A):
    """
    Forme normale de Smith selon votre code
    """
    m = A.nrows()
    n = A.ncols()
    H = copy(A)
    L = identity_matrix(A.base_ring(),m)
    U = identity_matrix(A.base_ring(),n)
    # ECRIVEZ VOTRE CODE ICI
    for k in range(min(n,m)) :
        if H[k,k] == 0 :
            if not cherche_pivot_et_echange(H,L,U,k) :
                return H,L,U
        while not test_arret(H,k) :
            bezout_lignes(H,L,k)
            bezout_colonnes(H,U,k)
            test_divisibilite(H,U,k)
    assert(H-L*A*U==0)
    return H,L,U

H1, L1, U1 = MySNF(X1)
H2, L2, U2 = MySNF(X2)

HQ, _, _ = MySNF(AQ)
HF2, _, _ = MySNF(AF2)
HF3, _, _ = MySNF(AF3)
HF5, _, _ = MySNF(AF5)

# test sur nb matrices aléatoires
def test(nb) :
    for i in range(nb):
        n = ZZ.random_element(10)
        m = ZZ.random_element(10)

        A = random_matrix(ZZ,n,m)
        H, _ , _= MySNF(A)
        HH, _ , _ = A.smith_form()
        for k in range(min(H.nrows(),H.ncols())):
            if abs(H[k,k]) != HH[k,k] : # sage renvoie des coefficients positifs, ce qui n'est pas le cas de notre algo
                                        # donc on teste l'égalité des valeurs absolues
                return False 
    return True

test = test(100) # Test a ecrire

# # Affichage des resultats

print("\n$ Question 4")
print("La matrice X1 = ")
print(X1)
print("a pour forme normale de Smith H1=")
print(H1)
print("et matrice de transformation L1=")
print(L1)
print("et matrice de transformation U1=")
print(U1)
print("La matrice X2 = ")
print(X2)
print("a pour forme normale de Smith H2=")
print(H2)
print("et matrice de transformation L2=")
print(L2)
print("et matrice de transformation U2=")
print(U2)

print("\n$ Question 5")
print("La forme normale de Smith sur Q est ")
print(HQ)
print("La forme normale de Smith sur F2 est ")
print(HF2)
print("La forme normale de Smith sur F3 est ")
print(HF3)
print("La forme normale de Smith sur F5 est ")
print(HF5)

print("\n$ Question 6")
print("Votre fonction coincide avec celle de Sage ?")
print(f'Le test vaut {test}')


print("""\
# ****************************************************************************
# RESOLUTION DE SYSTEME LINEAIRE HOMOGENE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

X = matrix(ZZ,[
      [ -2,  3,  3,  1],
      [  2, -1,  1, -3],
      [ -4,  0, -1, -4]])

# Code pour l'EXERCICE
H, U = MyHNF(X)
r=0
while r < H.ncols() and H[:,r] == 0 :
     r+=1

L =[U[:,i] for i in range(r)] # liste des vecteurs d'une base

# # Affichage des resultats

print("Le systeme a pour racine le module engendre par")
print(L)

print("""\
# ****************************************************************************
# IMAGE D'UNE MATRICE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A  = matrix(ZZ, [
           [ 15,  8, -9, 23,  -9],
           [ 22, 22,  7, -8,  20],
           [ 21, 18, -1, -7,  -3],
           [  3, -1,  0, 12, -16]])

# Code pour l'EXERCICE

I = identity_matrix(ZZ,4)
H, _ = MyHNF(A)
HH, _ = MyHNF(I)

# on va enlever les colonnes nulles de H
r = 0
while H[:,r] == 0 and r < H.ncols() :
    r+=1
H = H[:,r:]
    
test = (H == HH)

# # Affichage des resultats

print("L'image de")
print(A)
print("est-elle egale a ZZ^4 ?")
print(test)


print("""\
# ****************************************************************************
# RESOLUTION DE SYSTEME LINEAIRE NON-HOMOGENE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

X1 = matrix(ZZ,[
           [ -6,  12,  6],
           [ 12, -16, -2],
           [ 12, -16, -2]])

b1 = vector(ZZ,[ -6, 4, 4])

PolF5.<x> = PolynomialRing(GF(5))

X2 = matrix(PolF5,[
           [ x + 1, 2,     4],
           [     1, x,     2],
           [     1, 1, x + 1]])

b2 = vector(PolF5,[ 3*x+2, 0, -1])

X3 = matrix(ZZ, [
    [2,-3,4,0],
    [4,4,53,-2],
])

b3 = vector(ZZ,[-4,0])

# Code pour l'EXERCICE

def calcule_r(S):
    r = 0
    while r<min(S.nrows(),S.ncols()) and S[r,r]!=0 :
        r+=1
    return r  
    
def solve(X,b):
    S,L,C = X.smith_form()
    bb = L*b
    r = calcule_r(S)
    for i in range(r) :
        if bb[i] % S[i,i] != 0 :
            return (False, vector(X.base_ring(),1),identity_matrix(X.base_ring(),1))
    for i in range(r, S.nrows()) :
        if bb[i]!=0 :
            return (False, vector(X.base_ring(),1),identity_matrix(X.base_ring(),1))
    return (True, sum([bb[i]/S[i,i]*C[:,i] for i in range(r)]),C[:,r:])

if solve(X1,b1)[0] :
    z1 = solve(X1,b1)[1]

    H1 = solve(X1,b1)[2]
else : 
    z1, H1 = "Pas de solution", "Pas de solution"

if solve(X2,b2)[0] :
    z2 = solve(X2,b2)[1]

    H2 = solve(X2,b2)[2]
else : 
    z2, H2 = "Pas de solution", "Pas de solution"
    
if solve(X3,b3)[0] :
    z3 = solve(X3,b3)[1][:3] #on retire la dernière ligne qui correspond a la variable ajoutée pour le modulo

    H3 = solve(X3,b3)[2][:3,:] # idem
else : 
    z3, H3 = "Pas de solution", "Pas de solution"

# # Affichage des resultats

print("Une solution particuliere de X1*z1 = b1 est")
print(z1)
print("les solutions du systeme homogene sont engendres par")
print(H1)
print("Une solution particuliere de X2*z2 = b2 est")
print(z2)
print("les solutions du systeme homogene sont engendrees par")
print(H2)
print("Une solution particuliere du systeme 3 est")
print(z3)
print("les solutions du systeme homogene sont engendrees par")
print(H3)

print("""\
# ****************************************************************************
# STRUCTURE DU QUOTIENT
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
              [ -630,   735,   0,   735, -630],
              [ 1275, -1485, -15, -1470, 1275],
              [  630,  -630,   0,  -630,  630]])

# Code pour l'EXERCICE

S, L, C = A.smith_form()
inv_L = 1/L 
reponse = ""
for i in range(A.rank()):
    reponse+=f" Z/{S[i,i]}Z *"
if min(A.ncols(),A.nrows())-A.rank()>0 :
    reponse+=f"Z^{min(A.ncols(),A.nrows())-A.rank()}"
if reponse[-1]=="*" :
    reponse = reponse[:-1]
    
# # Affichage des resultats

print("La structure de Z^3/N est")
print(reponse)

print("""\
# ****************************************************************************
# FACTEURS INVARIANTS
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
              [ -630,   735,   0,   735, -630],
              [ 1275, -1485, -15, -1470, 1275],
              [  630,  -630,   0,  -630,  630]])


# Code pour l'EXERCICE

S, L, C = A.smith_form()
rang = min(A.nrows(),A.ncols()) - A.rank()
fact_inv = [S[i,i] for i in range(min(S.nrows(),S.ncols())) if S[i,i] !=0]
reponse = f"L'ensemble des exposants est ppcm(fact_inv)Z = {lcm(fact_inv)}Z" if rang == 0 else f"Il n'y a pas d'exposants"

# # Affichage des resultats

print("Le rang de Z^3 / N est")
print(rang)
print("Les facteurs invariants sont")
print(fact_inv)
print("Exposants ?")
print(reponse)

reset()