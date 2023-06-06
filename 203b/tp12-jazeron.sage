print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP12 : CRYPTANALYSE ET CRYPTOGRAPHIE A BASE DE RESEAUX                      #
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
# SAC A DOS (NE PAS TRAITER LA QUESTION 2)
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

b = [356,278,417,27,132,464,521]
s = 1287

# Code pour l'EXERCICE


M = matrix(ZZ,[[1 if i == j else 0 for i in range(len(b)+1)] for j in range(len(b)+1)])
for i in range(len(b)):
    M[len(b),i] = b[i]
M[len(b),len(b)] = -s
M = M.T
x = M.LLL()[0,:]
x = x.T
print(sum([x[i]*b[i] for i in range(len(b))]))

# # Affichage des resultats

print("Le message est")
print(list(x)[:-1])

reset()

print("""\
# ****************************************************************************
# ATTAQUE DE WIENER
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

N1 = 65946239999
e1 = 22022476093
N2 = 65946239999
e2 = 10865199773

# Code pour l'EXERCICE


phi = euler_phi(N1)

e1 = mod(e1,phi)
e2 = mod(e2,phi)

d1 = e1^(-1)
d2 = e2^(-1)

if d1 > d2 : 
    ans = (N1,e1)
else :
    ans = (N2,e2)


# # Affichage des resultats

print("Il vaut mieux utiliser la cle ",ans)

reset()
print("""\
# ****************************************************************************
# METHODE DE COPPERSMITH
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

Pol.<x> = PolynomialRing(ZZ)

# Code pour l'EXERCICE

def Coppersmith(f,N):
    Pol = f.parent()
    x = Pol.gen()
    d = f.degree()
    m = ceil(log(N,10)/d)
    B = ceil(N^(1/d)/(2*exp(1)))
    L = []
    for i in range(m+1):
        for j in range(d + 1) :
            L.append(((B*x)^j*N^i*f(B*x)^(m-i)).padded_list(2*d))
    M = matrix(L)
    i = 0
    while M[i,:] == 0 :
        i+=1
    h = M[i,:]
    h = vector(h)
    for i in range(len(h)):
        h[i] = h[i]//B^i
    h = Pol(list(h))
    R = h.roots()
    R = list(map(lambda xy : xy[0], filter(lambda xy : f(xy[0])==0%N and abs(xy[0])<=B, R)))
    return R


# # Affichage des resultats

p=(x+1)*(x-2)*(x-3)*(x-29)
print(Coppersmith(p,10000))

reset()

print("""\
# ****************************************************************************
# MESSAGES STEREOTYPES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

bin=BinaryStrings()
N = 42564360034887861127
Pol.<x> = PolynomialRing(ZZ)
PolmodN.<y> = PolynomialRing(Integers(N))
e = 3
c = 12843085802751039909

# Code pour l'EXERCICE

mm=str(bin.encoding("08/06:00"))
mm = '0'*(8*ceil(len(mm)/8)-len(mm))+mm
mm = mod(ZZ(mm,base=2),N)
f = PolmodN((mm+y)^e - c)
r = f.small_roots()[0]
mm = ZZ((mm+r)%N).str(2)
mm = '0'*(8*ceil(len(mm)/8)-len(mm))+mm
mm = bin(mm).decoding()

# # Affichage des resultats

print("Ce jour la, le message est")
print(mm)

reset()
print("""\
# ****************************************************************************
# ALGORITHME DE BABAI (NE TRAITER QUE LA QUESTION 1)
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE


# Passer en argument la matrice B ou les lignes sont les vecteurs générateurs
# du réseau
def Babai(B,t):
    n = B.nrows()
    b = t
    Bstar,_ = B.gram_schmidt()
    for j in range(n-1,-1,-1) : 
        uj = round(b.dot_product(vector(Bstar[j,:]))/vector(Bstar[j,:]).dot_product(vector(Bstar[j,:])))
        b = b - uj * vector(B[j,:])
    return t-b

# # Affichage des resultats
print("""\
# ****************************************************************************
# CRYPTOSYSTEME GGH
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

EE= matrix(ZZ,40, {(32, 32): 1, (22, 13): -2, (23, 8): -3,
       (15, 31): -1, (22, 37): -1,
       (13, 5): -4, (38, 20): 2, (4, 12): 3, (19, 22): -2, (15, 5): 2, (11,
       32): -1, (11, 10): 3, (1, 11): -4, (12, 33): 1, (0, 15): 1, (33, 17): 1,
       (7, 19): -1, (11, 1): -2, (7, 27): 3, (19, 32): -4, (22, 10): 2, (31,
       39): -4, (34, 9): 2, (36, 17): 2, (18, 17): 1, (14, 6): -2, (23, 14): 3,
       (23, 34): 2, (12, 11): -3, (0, 21): -3, (27, 22): -2, (4, 29): -3, (23,
       5): 1, (4, 6): -2, (24, 7): 2, (5, 38): -2, (33, 13): -1, (9, 35): 3,
       (18, 36): 1, (22, 5): 1, (24, 25): 3, (34, 31): 2, (6, 34): -3, (23,
       33): -4, (20, 37): -1, (38, 12): 2, (33, 0): -1, (4, 32): 3})
AA=(10*identity_matrix(40)+EE)
HH, U=AA.hermite_form(transformation=True)

cc = vector([-2, 0, 2, 0, 0, 1, -1, -1, -3, 0, 0, 2, -1, 13, 7, 2, 0, 2, 27, 2, 1,
       17, -2, 899, 50, 15, 11, 1098, 7, 2, -1, 10, -1, 2, 156, 15, 42, 8,
       525748584, 37])


# Code pour l'EXERCICE


bin = BinaryStrings()
def IntsToString(listints):
    return bin("".join([t.str(2) for t in listints])).decoding()

mm = Babai(AA,cc)
mm = U^(-1)*mm


# # Affichage des resultats

print("Je n'ai pas réussi cet exercice, je n'arrivais pas à savoir la convention employée pour la forme normale de smith dans l'exercice")