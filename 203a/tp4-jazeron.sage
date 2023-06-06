print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP4 : FACTORISATION DE POLYNOMES UNIVARIEES SUR CORPS FINIS                 #
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
# FACTORISATION DES PUISSANCES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

F1849.<omega> = FiniteField(43^2,modulus=x^2+1)
Pol1849.<x> = PolynomialRing(F1849)
f=x^172+(3-2*omega)*x^129-5*omega*x^86+(2 + 4*omega)*x^43-1-omega 

F9.<alpha> = FiniteField(9)
Pol9.<y> = PolynomialRing(F9)
g = y^30-y^15+alpha*y^3+1
# Code pour l'EXERCICE

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

# n est le nombre de tests et Pol l'anneau de polyômes sur lequel on teste
def test(n,Pol):
    for _ in range(n):
        f = Pol.random_element()
        p = Pol.characteristic()
        fp = f^p
        if racine_p_polynome(fp)!=f:
            return False
    return True

test100 = test(100,Pol9)

# # Affichage des resultats

print( "\n$ Question 3")
print( "La racine de",f,"est",racine_p_polynome(g))
print( "\n$ Question 4")
print( "Test sur 100 exemples : ",test100)




print("""\
# ****************************************************************************
# FACTORISATION SANS FACTEURS CARRES
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

F7 = FiniteField(7)
Pol7.<x> = PolynomialRing(F7)
f = x^10 +6*x^9 +3*x^7 +3*x^3 +4*x^2 +2

# Code pour l'EXERCICE

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

# n est le nombre de tests et Pol l'anneau de polyômes sur lequel on teste
def test(n,Pol):
    for _ in range(n):
        f = Pol.random_element()
        try : #on utilise le fait qu'on teste a la fin de la fonction que la décomposition est bonne
            myFsFC(f)
        except AssertionError :
            return False
    return True

test1000 = test(1000,Pol7)
    
# # Affichage des resultats

print( "\n$ Question 2")
print( "La factorisation de",f,"est",myFsFC(f))
print("\nSage donne la factorisation : f =", f.factor())
print( "\n$ Question 4")
print( "Test sur 1000 exemples : ",test1000)



print("""\
# ****************************************************************************
# FACTORISATION ETAGEE EN DEGRES DISTINCTS
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

F5 = FiniteField(5)
Pol.<x>=PolynomialRing(F5)
f = x^10-2*x^9+x^8+x^7-x^6-2*x^5+2*x^4+2*x^3-x

# Code pour l'EXERCICE


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

# # Affichage des resultats

print( "\n$ Question 1")
print( "La factorisation de",f,"est",myFEDD(f))

print("""\
# ****************************************************************************
# CANTOR-ZASSENHAUSS
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

q=3
d=4
Fq=FiniteField(q)
Polq.<x> = PolynomialRing(Fq) 
irred = [f for f in Polq.polynomials(of_degree=d) if f.is_irreducible()
 and f.leading_coefficient()==1]

# Code pour l'EXERCICE

def random_product(L):
    res= []
    LL=L.copy()
    k = randint(1,len(LL)-1) #nombre de termes du produit
    while k>0 :
        i = randint(0,len(LL)-1)
        res.append(LL.pop(i))
        k-=1
    return prod(res)

# n nombre de tests, d degré, irred irreductibles de ce degré, carac la caractéristique
def testCZ(carac,n,d,irred):
    for i in range(n):
        f = random_product(irred)
        try :
            if carac%2==0:
                myCZ2(f,d)
            else :
                myCZ(f,d)
        except AssertionError : 
            return False
    return True

def myCZ(f,d):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    if f.degree()==d:
        retour.append(f)
        return retour
    else :
        u = Pol.random_element((0,2*d-1))
        b = gcd(f,u^((q^d-1)/2)-1)
        while 0 >= b.degree() or b.degree() >= f.degree() :
            u = Pol.random_element((0,2*d-1))
            b = gcd(f,u^((q^d-1)/2)-1)
    r1 = myCZ(b,d)
    r2 = myCZ(f//b,d)
    retour = r1+r2
    assert(prod(retour) == f)
    return retour

testCZ20 = testCZ(q,20,d,irred)

q=2
d=4
Fq=FiniteField(q)
Polq.<x> = PolynomialRing(Fq) 
irred = [f for f in Polq.polynomials(of_degree=d) if f.is_irreducible()
 and f.leading_coefficient()==1]


def myCZ2(f,d):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    k = log(q,2)
    if f.degree()==d:
        retour.append(f)
        return retour
    else :
        tr = sum(x^(2^i) for i in range(k*d))
        u = Pol.random_element((0,2*d-1))
        b = gcd(f, tr(u))
        while 0>= b.degree() or b.degree() >= f.degree() :
            u = Pol.random_element((0,2*d-1))
            b = gcd(f, tr(u))
    r1 = myCZ2(b,d)
    r2 = myCZ2(f//b,d)
    retour = r1+r2
    assert(prod(retour) == f)
    return retour    

testCZ220 = testCZ(q,20,d,irred)
# # Affichage des resultats
print("\nLe test pour CZ impair vaut : ", testCZ20)
print("\nLe test pour CZ pair vaut :", testCZ220)


print("""\
# ****************************************************************************
# FACTORISATION COMPLETE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

q=3
Fq=FiniteField(q)
Polq.<x> = PolynomialRing(Fq) 
L1 = [f for f in Polq.polynomials(of_degree=1) if f.is_irreducible()
and f.leading_coefficient()==1]
L2 = [f for f in Polq.polynomials(of_degree=2) if f.is_irreducible()
and f.leading_coefficient()==1]
L3 = [f for f in Polq.polynomials(of_degree=3) if f.is_irreducible()
and f.leading_coefficient()==1]
    
f = L1[0]*L1[1]^3*L1[2]^4
f *= L2[0]*L2[1]^4*L2[2]^4
f *= L3[0]*L3[1]*L3[2]^2*L3[3]^2*L3[4]^3*L3[5]^3*L3[6]^4*L3[7]^4
factor(f)


# Code pour l'EXERCICE

def myFactorisation(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    alpha = list(f)[-1] #coeff en facteur
    f = f/alpha
    f_sans_carre = myFsFC(f)
    for (g,i) in f_sans_carre :
        g_deg_distinct = myFEDD(g)
        for j in range(len(g_deg_distinct)) :
            if g_deg_distinct[j]!= Pol(1) :
                if p%2 == 0:
                    irred = myCZ2(g_deg_distinct[j],j+1)
                else :
                    irred = myCZ(g_deg_distinct[j],j+1)
                for u in irred :
                    retour.append((u,i))
    assert(alpha*prod([f^e for (f,e) in retour ]) == f)
    return (retour, alpha)



# # Affichage des resultats

print( "\n$ Question 1")
facto, alpha = myFactorisation(f)
print( "La factorisation de",f,"est",facto, "\nAvec le coefficient dominant :", alpha )

print("""\
# ****************************************************************************
# RACINES D'UN POLYNOME
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

q=3
Fq=FiniteField(q)
Polq.<x> = PolynomialRing(Fq) 
L1 = [f for f in Polq.polynomials(of_degree=1) if f.is_irreducible()
and f.leading_coefficient()==1]
L2 = [f for f in Polq.polynomials(of_degree=2) if f.is_irreducible()
and f.leading_coefficient()==1]
L3 = [f for f in Polq.polynomials(of_degree=3) if f.is_irreducible()
and f.leading_coefficient()==1]
    
f = L1[0]*L1[1]^3*L1[2]^4
f *= L2[0]*L2[1]^4*L2[2]^4
f *= L3[0]*L3[1]*L3[2]^2*L3[3]^2*L3[4]^3*L3[5]^3*L3[6]^4*L3[7]^4


# Code pour l'EXERCICE


def myRacine(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    retour = []
    facto, alpha = myFactorisation(f)
    for (irr, puissance) in facto :
        if irr.degree() == 1 :
            root = Pol.base_ring()(-(irr - x))
            retour.append(root)
    assert(f(z)==0 for z in retour)
    return retour

# # Affichage des resultats

print( "\n$ Question 1")
print( "Les racines de ",f,"sont",myRacine(f))

print("""\
# ****************************************************************************
# ETUDE DE CANTOR-ZASSENHAUSS
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

q=3
d=10
Fq=FiniteField(q)
Polq.<x> = PolynomialRing(Fq) 
f1 = Polq.irreducible_element(d, 'random')
f2 = Polq.irreducible_element(d, 'random')
while f1==f2:
    f2 = Polq.irreducible_element(d, 'random')
f=f1*f2
S1.<x> = Polq.residue_field(f1)
S2.<x> = Polq.residue_field(f2)

# Code pour l'EXERCICE

c1 = S1.random_element()
c2 = S2.random_element()
while not c1.is_square() or not c2.is_square():
    c1 = S1.random_element()
    c2 = S2.random_element()
    
nc1 = S1.random_element()
nc2 = S2.random_element()
while nc1.is_square() or nc2.is_square():
    nc1 = S1.random_element()
    nc2 = S2.random_element()
c1,c2,nc1,nc2 = Polq(c1),Polq(c2),Polq(nc1),Polq(nc2)
    
u1 = crt(c1,c2,f1,f2) # carré mod f1, carré mod f2
u2 = crt(nc1,c2,f1,f2) # non carré mod f1, carré mod f2
u3 = crt(c1,nc2,f1,f2) # carré mod f1, non carré mod f2
u4 = crt(nc1,nc2,f1,f2) # non carré mod f1, non carré mod f2
# # Affichage des resultats

print("f1 vaut :\n", f1)
print("f2 vaut :\n", f2)
print("Cas ou u est carré mod f1 et mod f2 :\n", gcd(f,u1^((q^d-1)/2)-1))
print("Cas ou u n'est pas carré mod f1 mais l'est mod f2 :\n", gcd(f,u2^((q^d-1)/2)-1))
print("Cas ou u est carré mod f1 mais pas mod f2 :\n", gcd(f,u3^((q^d-1)/2)-1))
print("Cas ou u n'est carré ni mod f1 ni mod f2 :\n", gcd(f,u4^((q^d-1)/2)-1))
print("""\nOn observe que si u est carré mod f1 et f2, on a f1*f2, si u est carré mod f1 et pas f2 on obtient f1 
et vice-versa, et si u n'est carré ni mod f1 ni f2, on obtient 1""")