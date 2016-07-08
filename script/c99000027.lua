--???衆の?�払??
function c99000027.initial_effect(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c99000027.con)
	e2:SetTarget(c99000027.lvtg)
	e2:SetOperation(c99000027.lvop)
	c:RegisterEffect(e2)
	--cannot release
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UNRELEASABLE_SUM)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e5)
end
function c99000027.confilter(c)
	return c:IsFaceup() and c:IsSetCard(0xAC26)
end
function c99000027.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c99000027.confilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c99000027.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c99000027.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99000027.filter,tp,LOCATION_MZONE,0,1,nil) end
	e:SetLabel(4)
end
function c99000027.lvop(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	local g=Duel.GetMatchingGroup(c99000027.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end