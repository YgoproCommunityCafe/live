--龜樹�?
function c99000036.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,20,2)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99000036,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c99000036.remcost)
	e2:SetTarget(c99000036.remtg)
	e2:SetOperation(c99000036.remop)
	c:RegisterEffect(e2)
	--cannot release
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ea:SetRange(LOCATION_MZONE)
	ea:SetCode(EFFECT_UNRELEASABLE_SUM)
	ea:SetValue(1)
	c:RegisterEffect(ea)
	local eb=ea:Clone()
	eb:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(eb)
end
function c99000036.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c99000036.remcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c99000036.sfilter(c)
	return c:IsFaceup()
end
function c99000036.remtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end
function c99000036.remop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local ctlv=g:GetSum(Card.GetLevel)
	local ctrk=g:GetSum(Card.GetRank)
	local ct1=(ctlv+ctrk)/20
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct1>ct2 then ct1=ct2 end
	local t={}
	for i=1,ct1 do t[i]=i end
	local g=Duel.GetDecktopGroup(1-tp,ct1)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end