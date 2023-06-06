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

def PetrBerlekamp(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    n=f.degree()
    Q = zero_matrix(Pol.base_ring(),n)
    for j in range(n):
        vec = (x^j)^q % f
        for i in range(n):
            Q[i,j] = vec[i]
    return Q

def myB(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    n=f.degree()
    Q = PetrBerlekamp(f)
    ker_basis = (Q-identity_matrix(n)).right_kernel().basis()
    k = len(ker_basis)
    j = 0
    retour = [f]
    while len(retour) < k :
        j+=1
        C = [ff for ff in retour if ff.degree()>1]
        for ff in C :
            B = []
            for alpha in Pol.base_ring() :
                a = gcd(ff,Pol(list(ker_basis[j]))-alpha)
                if a.degree() >= 1 :
                    B.append(a)
            retour.remove(ff)
            retour+=B
    assert(Set(retour) == Set(g for g,_ in list(f.factor())))
    return retour

def racine_p_polynome(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    u=Pol(0)
    coeffs = list(f)
    coeffs = coeffs[0:f.degree()+1:p]
    for i in range(len(coeffs)):
        u += coeffs[i]^(q/p) * x^i
    assert(u^p==f)
    return u

def myFsFC(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    d = f.degree()
    if d<= 0:
        return []
    elif f.derivative()!=0:
        i=1
        L=[]
        t=gcd(f.derivative(),f)
        u = f//t
        while u!=Pol(1):
            y = gcd(t,u)
            if i%p!=0 and u//y != Pol(1) :
                L.append((u//y,i))
            i+=1
            u=y
            t=t//y
        if t!= Pol(1) :
            LL = myFsFC(racine_p_polynome(t))
            for (s,j) in LL :
                L.append((s,p*j))
    else : 
        LL = myFsFC(racine_p_polynome(f))
        for (s,j) in LL :
            L.append((s,p*j))
    assert(prod([f^e for (f,e) in L ]) == f)
    return L

def myFEDD(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    hi=x
    fi=f
    i=0
    while fi!=Pol(1):
        hi = hi^q % f
        gi = gcd(fi,hi-x)
        retour.append(gi)
        fi = fi//gi
    assert(prod(retour) == f)
    return retour

def myFactor(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    f_sans_carre = myFsFC(f)
    for (g,i) in f_sans_carre :
        g_deg_distinct = myFEDD(g)
        for j in range(len(g_deg_distinct)) :
            if g_deg_distinct[j]!= Pol(1) :
                irred = myB(g_deg_distinct[j])
                for u in irred :
                    retour.append((u,i))
    assert(Set(retour) == Set(list(f.factor())))
    return retour

# n est le nombre de tests et Pol l'anneau de polynome sur lequel on teste
def testFacto(n,Pol):
    for _ in range(n):
        f = Pol.random_element(1,10)
        f = f/f[f.degree()] # on retire le coeff dominant, on ne teste que sur des polynomes unitaires
        try : #on utilise le fait qu'on teste a la fin de la fonction que la décomposition est bonne
            myFactor(f)
        except AssertionError :
            return False
    return True

test100=testFacto(100,PolynomialRing(FiniteField(9),'a')) # on fait 100 tests sur F9

x3 = x^3 % f
x6 = x^6 % f
Q = PetrBerlekamp(f)

b1 = vector(F3,[1,0,0])
b2 = vector(F3,[0,1,1])

L = myB(f)

# # Affichage des resultats


print("\n$1a/ x^3 vaut",x3," et x^6 vaut",x6)
print("La matrice de Petr Berlekamp est")
print(Q)

print("\n$1b/ On a Q * b1 - b1 = ")
print(Q*b1-b1)
print("et Q * b2 - b2 = ")
print(Q*b2-b2)

print("\n$1c/ La factorisation de f est :")
print(L)

print("\n Le résultat de 100 tests sur F9 de la factorisation est : ")
print(test100)

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



def polynomeCentre(f,m):
    Pol=f.parent()
    x=Pol.gen()
    retour = Pol([mod(coeff,m).lift_centered() for coeff in list(f)])
    return retour

def reduire_coeffs(f,m):
    Pol=f.parent()
    x=Pol.gen()
    retour = Pol([mod(coeff,m) for coeff in list(f)])
    return retour

def myHensel(f,g,h,s,t,m):
    Pol=f.parent()
    x=Pol.gen()
    e = reduire_coeffs(f-g*h,m^2)
    q,r = (s*e) // h, (s*e) % h
    q,r = reduire_coeffs(q,m^2), reduire_coeffs(r, m^2)
    g_star = reduire_coeffs(g + t*e + q*g, m^2)
    h_star = reduire_coeffs(h+r,m^2)
    b = reduire_coeffs(s*g_star+t*h_star -1,m^2)
    c, d = (s*b) // h_star, (s*b) % h_star
    c, d = reduire_coeffs(c,m^2), reduire_coeffs(d, m^2)
    s_star = reduire_coeffs(s-d, m^2)
    t_star = reduire_coeffs(t - t*b - c*g_star, m^2)
    return (polynomeCentre(g_star,m^2),polynomeCentre(h_star,m^2),polynomeCentre(s_star,m^2),polynomeCentre(t_star,m^2))

def myHenselItere(f,g,h,s,t,p,l):
    Pol=f.parent()
    x=Pol.gen()
    borne = p^l
    while p < borne :
        g,h,s,t = myHensel(f,g,h,s,t,p)
        p = p^2
    return g,h

reponseQ5="""\nSi f se factorise en produit de plus de deux facteurs on en isole un (disons g) \
qui soit premier avec les autres,on obtient ainsi un produit de deux facteurs, f=gh, on relève pour\
avoir f=gstar * hstar modulo p^l, puis on factorise hstar modulo p, et récursivement on relève\
 cette factorisation modulo p^l"""

# # Affichage des resultats
print("\n Relèvement modulo 25 de ",f,"= (",g,")*(",h,")")
print(myHensel(f,g,h,s,t,m))
print("\n Relèvement modulo 625 de ",f,"= (",g,")*(",h,")")
print(myHenselItere(f,g,h,s,t,5,4))
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
Pol13.<x> = PolynomialRing(FiniteField(13))
fhat = Pol13(f) # reduc modulo 13 de f
R = Integers(p^k)
PolR.<x> = PolynomialRing(R) # Z/13^4Z[X]
ftilde= PolR(f) # reduco modulo 13^4 de f
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

racinesF13 = fhat.roots()
alpha, beta, gamma, delta = racinesF13[0][0], racinesF13[1][0], racinesF13[2][0], racinesF13[3][0]
racines_Z13puiss4 = ftilde.roots(multiplicities=False)
racines_Z13puiss4 = [racine.lift_centered() for racine in racines_Z13puiss4]
for x in racines_Z13puiss4 :
    if x % 13 == alpha :
        alphahat = x
    elif x % 13 == beta :
        betahat = x
    elif x % 13 == gamma :
        gammahat = x
    elif x % 13 == delta :
        deltahat = x

uu = PolR(u)
test = (ftilde % uu == 0)

d = u.degree()
j=3

x = PolZZ.gen()
L = [u*PolZZ(x^i) for i in range(j-d)] + [m*PolZZ(x^i) for i in range(j)]
M = Matrix(ZZ, len(L), j, [[L[h][i] for i in range(j)] for h in range(len(L))])
LLL_basis = M.LLL()
i=0
while not(any(LLL_basis[i,:])):
    i+=1
vecteur_court = list(LLL_basis.row(i))
g = PolZZ(vecteur_court)
fact1 = gcd(g,f)
fact2 = f/fact1

# # Affichage des resultats

print("\n$1a/ Les racines sont", alpha, beta, gamma, delta,"modulo",p)
print("\n$1b/ Les racines sont", alphahat, betahat, gammahat, deltahat,"modulo",m)
print("\n$2a/ On teste que u divise f modulo 13^4 :", test)
print("\n$2b/ On en déduit un facteur de f :", fact1)
print("\n$2c/ Puisque aucune des racines de f dans Z/13^4 ne sont racines dans Z, on en déduit la factorisation de f:")
print("\n f=(",fact1,")*(",fact2,")")